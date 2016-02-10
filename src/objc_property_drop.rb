module Liquid
  class ObjcPropertyDrop < Drop
    def initialize(objc_property)
      @objc_property = objc_property
    end

    def type
      @objc_property.type.unqualified_string
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
      @objc_property.should %i[ implement validator ]
    end

    def field_name
      '_' + @objc_property.name
    end

    def field_name_boxed
      return field_name if reference_type?
      "@(#{field_name})"
    end

    def attributes_string(attributes)
      attributes.reject { |opt| [:nullable, :nonnull].include? opt }
                .map { |opt| opt.to_s }
                .reduce { |f, s| f + ', ' + s }
    end

    def attributes
      attributes_string(@objc_property.options)
    end

    def readonly_attributes
      attributes_string(@objc_property.options.map { |opt| opt == :readwrite ? :readonly : opt })
    end

    def builder_attributes
      options = @objc_property.options
      # remove readonly semantics
      options = options.map { |opt| opt == :readonly ? :readwrite : opt }
      # remove copy semantics
      options = options.map { |opt| opt == :copy ? :retain : opt }

      attributes_string(options)
    end

    def setter_name
      "set#{name.upcase_1l}"
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