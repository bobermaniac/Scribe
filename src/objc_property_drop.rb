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

    def attributes
      attributes = @objc_property.options.reject { |opt| [:mutable, :immutable, :nullable, :nonnull].include? opt }
          .map { |opt| opt.to_s }
          .reduce { |f, s| f + ', ' + s }
      return attributes unless @objc_property.options.include? :immutable
      "#{attributes}, readonly"
    end

    def readonly_attributes
       return attributes if attributes.include? 'readonly'
       "#{attributes}, readonly"
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