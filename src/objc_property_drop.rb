module Liquid
  class ObjcPropertyDrop < Drop
    def initialize(objc_property)
      @objc_property = objc_property
    end

    def type
      @objc_property.type.unqualified_string
    end

    def subsequent_generic_types
      return %w[ id id ] unless @objc_property.type.generic_subtypes
      @objc_property.type.generic_subtypes.map { |t| t.qualified_string } or %w[ id id ]
    end

    def type_qualified
      @objc_property.type.qualified_string
    end

    def builder_type_qualified
      @objc_property.builder_type.qualified_string
    end

    def name
      @objc_property.name
    end

    def element_name
      name = @objc_property.should(%i[ implement collection ]).reject{ |(c, _)| c.nil? }.map{ |(c, _)| c }.first
      return name unless name.nil?
      "#{self.name}Object"
    end

    def element_name_capitalized
      self.element_name.upcase_1l
    end

    def copy_on_assign?
      @objc_property.options.include? :copy
    end

    def atomic?
      @objc_property.options.include? :atomic
    end

    def reference_type?
      (@objc_property.options & [:strong, :weak]).any?
    end

    def validate?
      @objc_property.validate?
    end

    def validators
      @objc_property.validators.map { |v| v.first }
    end

    def collection?
      @objc_property.type.collection_type? and @objc_property.should %i[ implement collection ]
    end

    def array?
      @objc_property.type.array_type?
    end

    def dictionary?
      @objc_property.type.dictionary_type?
    end

    def set?
      @objc_property.type.set_type?
    end

    def field_name
      '_' + @objc_property.name
    end

    def field_name_boxed
      return field_name if reference_type?
      "@(#{field_name})"
    end

    def name_boxed
      return @objc_property.name if reference_type?
      "@(#{@objc_property.name})"
    end

    def attributes_string(attributes)
      attributes.reject { |opt| [:nullable, :nonnull].include? opt }
                .map { |opt| opt.kind_of?(Array) ? opt.join('=') : opt.to_s }
                .reduce { |f, s| f + ', ' + s }
    end

    def attributes
      attributes_string(@objc_property.options)
    end

    def readonly_attributes
      attributes_string(@objc_property.options.map { |opt| opt == :readwrite ? :readonly : opt }.reject { |opt| opt.kind_of?(Array) and opt.first == :setter })
    end

    def builder_attributes
      options = @objc_property.options
      # remove readonly semantics
      options = options.map { |opt| opt == :readonly ? :readwrite : opt }
      # remove copy semantics
      options = options.map { |opt| opt == :copy ? :retain : opt }

      attributes_string(options)
    end

    def getter_name
      getter = @objc_property.options.select{ |o| o.kind_of? Array }.select{ |(o, _)| o == :getter }.first
      return getter.last unless getter.nil?
      self.name
    end

    def setter_name
      setter = @objc_property.options.select{ |o| o.kind_of? Array }.select{ |(o, _)| o == :setter }.first
      return setter.last unless setter.nil?
      "set#{self.name.upcase_1l}:"
    end

    def validator_name
      "_validate#{name.upcase_1l}"
    end

    def decoding_method
      "decode#{@objc_property.type.coding_method}ForKey"
    end

    def encoding_method
      "encode#{@objc_property.type.coding_method}"
    end

    def immutable_copy_method
      return '<v>' unless @objc_property.type.reference_type?
      return 'SCObjectImmutableCopy(<v>, error)' if @objc_property.type.requires_immutable_copy?
      '<v>'
    end
  end
end

module Objc
  class Property
    def to_liquid
      Liquid::ObjcPropertyDrop.new(self)
    end
  end
end