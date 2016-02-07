module MythGenerator
  class Treetop::Runtime::SyntaxNode
    protected
    def children_of_type(type)
      self.elements.select { |item| item.is_a? type }
    end

    def text_value_of_child(type)
      children_of_type(type).first.text_value
    end
  end

  class InterfaceDefinitions < Treetop::Runtime::SyntaxNode
    def classes
      self.elements[1].children_of_type InterfaceDefinition
    end
  end

  class InterfaceDefinition < Treetop::Runtime::SyntaxNode
    def imports
      self.parent.parent.text_value_of_child ImportDefinitions
    end

    def supports
      supports = children_of_type SupportsDefinition
      supports = supports.flat_map { |item| item.elements }
      supports = supports.flat_map { |item| item.elements }
      supports = supports.select { |item| item.is_a? Identifier }

      supports.map {|item| item.text_value.to_sym }
    end

    def class_name
      text_value_of_child Identifier
    end

    def superclass_name
      definition = children_of_type SuperclassDefinition
      return "NSObject" if definition.empty?
      definition.first.class_name
    end

    def properties
      section = children_of_type PropertyDefinitions
      return [] if section.empty?
      section.first.properties
    end

  end

  class SuperclassDefinition < Treetop::Runtime::SyntaxNode
    def class_name
      text_value_of_child Identifier
    end
  end

  class PropertyDefinitions < Treetop::Runtime::SyntaxNode
    def properties
      children_of_type PropertyDefinition
    end
  end

  class PropertyDefinition < Treetop::Runtime::SyntaxNode
    private
    def self.all_options(options)
      return [] if options == nil

      options.flat_map do |opt|
        if opt.is_a? Identifier
          [ opt ]
        else
          self.all_options(opt.elements)
        end
      end
    end

    def extend_options_with_defaults(options)
      is_reference_type = (type_name.end_with?('*') or type_name == 'id')
      result = []

      if options.include? :atomic or not options.include? :nonatomic
        result << :atomic
      else
        result << :nonatomic
      end

      if options.include? :assign
        result << :assign
      elsif options.include? :retain
        result << :retain
      elsif options.include? :copy
        result << :copy
      else
        if is_reference_type
          result << :retain
        else
          result << :assign
        end
      end

      if options.include? :weak
        result << :weak
      elsif is_reference_type
        result << :strong
      end

      if options.include? :readonly
        result << :readonly
      else
        result << :readwrite
      end

      if options.include? :nullable
        result << :nullable
      elsif options.include? :nonnull
        result << :nonnull
      else
        if is_reference_type
          result << :nullable
        end
      end

      result
    end

    public
    def options
      options = children_of_type PropertyOptions
      return [] unless options.any?

      options = PropertyDefinition.all_options(options)
      extend_options_with_defaults options.map { |opt| opt.text_value.to_sym }
    end

    def type_name
      text_value_of_child Type
    end

    def name
      text_value_of_child Identifier
    end
  end

  class SupportsDefinition < Treetop::Runtime::SyntaxNode
  end

  class SupportDefinition < Treetop::Runtime::SyntaxNode
  end

  class PropertyOptions < Treetop::Runtime::SyntaxNode
  end

  class Keyword < Treetop::Runtime::SyntaxNode
  end

  class Whitespace < Treetop::Runtime::SyntaxNode
  end

  class Identifier < Treetop::Runtime::SyntaxNode
  end

  class Type < Treetop::Runtime::SyntaxNode
    def text_value
      Type.normalize_type(self)
    end

    def self.normalize_type(type)
      buffer = StringIO.new

      for element in type.elements
        if element.is_a?(Type) or element.is_a?(Identifier)
          buffer << element.text_value
        elsif element.is_a?(GenericSubtype)
          buffer << "<#{normalize_type(element)}>"
        elsif element.is_a?(GenericSubtypeS2)
          buffer << normalize_type(element)
        elsif element.is_a? Treetop::Runtime::SyntaxNode
          if element.text_value.strip == ','
            buffer << ', '
          elsif element.text_value.strip == '*'
            buffer << ' *'
          end
        end
      end

      buffer.string
    end
  end

  class GenericSubtype < Treetop::Runtime::SyntaxNode

  end

  class GenericSubtypeS2 < Treetop::Runtime::SyntaxNode

  end

  class ImportDefinitions < Treetop::Runtime::SyntaxNode

  end
end