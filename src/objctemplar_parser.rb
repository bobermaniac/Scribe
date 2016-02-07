module MythGenerator
  class Treetop::Runtime::SyntaxNode
    protected
    def children_of_type(type)
      return [] if self.elements.nil?
      self.elements.select { |item| item.is_a? type }
    end

    def self.recursive_children_of_type(elements, type)
      return [] if elements == nil

      elements.flat_map do |e|
        if e.is_a? type
          [ e ]
        else
          self.recursive_children_of_type(e.elements, type)
        end
      end
    end

    def recursive_children_of_type(type)
      self.class.recursive_children_of_type(self.elements, type)
    end

    def text_value_of_child(type)
      children_of_type(type).first.text_value
    end
  end

  class InterfaceDefinitions < Treetop::Runtime::SyntaxNode
    def classes
      self.elements.flat_map { |item| item.children_of_type InterfaceDefinition  }
    end
  end

  class InterfaceDefinition < Treetop::Runtime::SyntaxNode
    def imports
      self.parent.parent.text_value_of_child ImportDefinitions
    end

    def scribes
      self.children_of_type ScribeDefinitions
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

  class ScribeDefinitions < Treetop::Runtime::SyntaxNode
    private
    def self.all_directive_groups(elements)

    end

    public
    def all_definitions
      elements.flat_map do |scribe_definition|
        scribe_definition.recursive_children_of_type(ScribeDirectiveGroup).flat_map do |scribe_directive_group|
          verb = scribe_directive_group.text_value_of_child Identifier

          scribe_directive_group.recursive_children_of_type(ScribeDirective).map do |scribe_directive|
            item = ScribeFlatDefinition.new
            item.verb = verb
            item.pattern = scribe_directive.text_value_of_child Identifier

            parameter = scribe_directive.children_of_type(ScribeDirectiveParameter).first
            item.parameter = parameter.text_value_of_child Identifier unless parameter.nil?

            item
          end
        end
      end
    end
  end

  class ScribeFlatDefinition
    def initialize

    end

    attr_accessor :verb
    attr_accessor :pattern
    attr_accessor :parameter
  end

  class ScribeDefinition < Treetop::Runtime::SyntaxNode

  end

  class ScribeDirectiveGroup < Treetop::Runtime::SyntaxNode

  end

  class ScribeDirective < Treetop::Runtime::SyntaxNode

  end

  class ScribeDirectiveParameter < Treetop::Runtime::SyntaxNode

  end

  class ScribeDefaultsMarker < Treetop::Runtime::SyntaxNode

  end
end