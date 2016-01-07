module Liquid
  class ObjcPropertyDrop < Drop
    def initialize(objc_property)
      @objc_property = objc_property
    end

    def type
      @objc_property.type
    end

    def type_qualified
      @objc_property.type_qualified
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

    def field_name
      '_' + @objc_property.name
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
      attributes_string(@objc_property.options - [ :readwrite, :readonly ] + [ :readonly ])
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