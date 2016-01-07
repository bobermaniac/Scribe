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
    def dump_protocols(dict)
      protocols = dict.select {|k, v| @objc_class.supports.include? k }.map { |k, v| v }
      return '' if not protocols.any?
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
      @objc_class.ancestor
    end

    def properties
      @objc_class.properties
    end

    def all_properties
      @objc_class.all_properties
    end

    def immutable_properties
      @objc_class.all_properties.select { |p| p.options.include?(:immutable) }
    end

    def immutable_own_properties
      @objc_class.properties.select { |p| p.options.include?(:immutable) }
    end

    def all_mutable_properties
      @objc_class.all_mutable_properties
    end

    def protocols
      dump_protocols({ :mutable_copy => 'NSMutableCopying' })
    end

    def mutable_protocols
      dump_protocols({ :track_changes => 'TCTrackChanges' })
    end

    def imports
      import = @objc_class.ancestor.root? ? '<Foundation/Foundation.h>' : "\"#{@objc_class.ancestor.name}.h\""
      "#import #{import}\n#{@objc_class.imports}".strip
    end

    def close_parent_ctor?
      immutable_own_properties.any?
    end

    def prim_ctor_definition
      immutable_props = immutable_properties
      return ' ' if not immutable_props.any?

      immutable_props.map do |property|
        "#{property.name.upcase_1l}:(#{property.type_qualified})#{property.name} "
      end.reduce('With') { |acc, item| acc + (acc.end_with?(' ') ? item.downcase_1l : item) }
    end

    def prim_ctor_call
      immutable_props = immutable_properties
      return '' if not immutable_props.any?

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

    def copy_ctor_param
      nontrivial_ancestor_info[:name].downcase_1l
    end

    def have_mutable_version
      @objc_class.supports.include? :mutable_copy
    end

    def should_track_changes
      @objc_class.supports.include? :track_changes
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