module Liquid
  String.class_eval do
    def downcase_1l
      self[0, 1].downcase + self[1..-1]
    end

    def upcase_1l
      self[0, 1].upcase + self[1..-1]
    end
  end

  class ObjcClassDrop < Drop

    private
    def dump_protocols(dict, additional = nil)
      protocols = dict.select {|k, v| @objc_class.supports.include? k }.map { |k, v| v }
      protocols = additional + protocols unless additional == nil
      return '' unless protocols.any?
      "<#{ protocols.reduce { |f, s| f + ', ' + s} }>"
    end

    public
    def initialize(objc_class)
      @objc_class = objc_class
    end

    def class_name
      @objc_class.name
    end

    def mutable_class_name
      Objc.prefix_for_typename(class_name) + 'Mutable' + Objc.typename_without_prefix(class_name)
    end

    def parent
      @objc_class.ancestor.to_liquid
    end

    def supports_mutable_copy?
      @objc_class.should %i[ implement mutable ]
    end

    def supports_track_changes?
      @objc_class.should %i[ implement tracking ]
    end

    def supports_builder?
      @objc_class.should %i[ implement builder ]
    end

    def abstract?
      @objc_class.should %i[ make abstract ]
    end

    def archivable?
      @objc_class.should %i[ implement archivable ]
    end

    def parent_have_builder?
      @objc_class.ancestor.should %i[ implement builder ]
    end

    def constructor_could_fail?
      self.parent.constructor_could_fail? unless self.parent.nil?
      @objc_class.properties.any? { |p| p.validate? and p.readonly? }
    end

    def builder_could_fail?
      self.parent.builder_could_fail? unless self.parent.nil?
      @objc_class.properties.any? { |p| p.validate? }
    end

    def own_properties
      @objc_class.properties
    end

    def all_properties
      @objc_class.all_properties
    end

    def own_immutable_properties
      @objc_class.properties.select { |p| p.options.include?(:readonly) }
    end

    def all_immutable_properties
      @objc_class.all_properties.select { |p| p.options.include?(:readonly) }
    end

    def all_mutable_properties
      @objc_class.all_mutable_properties
    end

    def builder_properties
      if parent_have_builder?
        own_properties
      else
        all_properties
      end
    end

    def protocols
      immutable_copy = Scribe.default_interfaces['immutable copy']['protocol']
      dump_protocols({ mutable_copy: 'NSMutableCopying', make_archivable: 'NSCoding' }, [ @objc_class.ancestor.name, 'NSCopying', immutable_copy ] )
    end

    def mutable_protocols
      additional = [ class_name ]
      additional << parent.mutable_class_name if parent.supports_mutable_copy?

      dump_protocols({ :track_changes => Scribe.default_interfaces['tracking']['protocol'] }, additional)
    end

    def imports_str(values)
      '' if values.nil?
      '' unless values.any?
      values.map { |i| "#import #{i}"}.join "\n"
    end

    def imports
      superclass_import = @objc_class.ancestor.root? ? Scribe.default_interfaces['foundation'] : "\"#{@objc_class.ancestor.name}.h\""
      self.imports_str [ superclass_import ]
    end

    def impl_imports
      validator_imports = self.all_properties.flat_map { |p| p.should %i[ implement validator ] }
                              .select { |v| v }.map { |(cls, path)| path.nil? ? "\"#{cls}.h\"" : path }.uniq
      self.imports_str validator_imports
    end

    def close_parent_ctor?
      own_immutable_properties.any?
    end

    def prim_ctor_definition
      immutable_props = all_immutable_properties
      return ' ' unless immutable_props.any?

      definition = immutable_props.map do |property|
        "#{property.name.upcase_1l}:(#{property.type.qualified_string})#{property.name} "
      end.reduce('With') { |acc, item| acc + (acc.end_with?(' ') ? item.downcase_1l : item) }
    end

    def prim_ctor_call
      immutable_props = all_immutable_properties
      return '' unless immutable_props.any?

      immutable_props.map do |property|
        "#{property.name.upcase_1l}:#{property.name} "
      end.reduce('With') { |acc, item| acc + (acc.end_with?(' ') ? item.downcase_1l : item) }.strip
    end

    def nontrivial_ancestor_info
      ancestor = @objc_class.first_nontrivial_ancestor
      {
          :type => ancestor.name,
          :name => Objc.typename_without_prefix(ancestor.name)
      }
    end

    def copy_ctor_definition
      ancestor_info = nontrivial_ancestor_info
      "With#{ancestor_info[:name].upcase_1l}:(#{@objc_class.name} * _Nonnull)#{ancestor_info[:name].downcase_1l} "
    end

    def copy_ctor_call
      return '' if @objc_class.root?
      ancestor_info = nontrivial_ancestor_info
      "With#{ancestor_info[:name].upcase_1l}:#{ancestor_info[:name].downcase_1l}"
    end

    def prim_ctor_call_for_builder
      immutable_props = all_immutable_properties
      return '' unless immutable_props.any?

      immutable_props.map do |property|
        "#{property.name.upcase_1l}:builder.#{property.name} "
      end.reduce('With') { |acc, item| acc + (acc.end_with?(' ') ? item.downcase_1l : item) }.strip
    end

    def copy_ctor_param
      nontrivial_ancestor_info[:name].downcase_1l
    end
  end
end

module Objc
  class Class
    def to_liquid
      Liquid::ObjcClassDrop.new(self)
    end
  end
end