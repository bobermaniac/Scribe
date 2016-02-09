require_relative 'objc_class'

module Scribe
  class Directive
    attr_accessor :verb
    attr_accessor :option
    attr_accessor :parameter

    def parameter?
      not self.parameter.nil?
    end

    def default=(value)
      @default = value
    end

    def default?
      @default
    end

    def initialize(verb)
      @verb = verb
      @option = nil
      @parameter = nil
      @default = false

      yield(self) if block_given?
    end

    def to_s
      "#{self.default? ? 'default ' : ''}#{self.verb} #{self.option}#{self.parameter? ? (' = ' + self.parameter) : ''}"
    end
  end

  def self.parse_interfaces_definition(interfaces_definition)
    context = { global_scribes: interfaces_definition.scribes, imports: interfaces_definition.imports }
    interfaces_definition.interfaces.map do |interface_definition|
      self.parse_interface_definition(interface_definition, context)
    end
  end

  def self.parse_interface_definition(interface_definition, context)
    name = interface_definition.class_name.value
    superclass_name = interface_definition.superclass_name
    superclass_name = superclass_name.class_name.value unless superclass_name.nil?

    Objc::Class.new(name, superclass_name) do |a_class|
      context[:class_scribes] = interface_definition.scribes

      a_class.scribes = self.parse_scribes([ context[:global_scribes], context[:class_scribes] ])
      a_class.properties = self.parse_properties_definition(interface_definition.properties, context)
    end
  end

  def self.parse_properties_definition(properties_definition, context)

  end

  def self.parse_scribes(scribes_priority_list)
    scribes_flat_list = scribes_priority_list.flat_map { |scribes_definition| self.parse_scribes_definition scribes_definition }
    self.flatten_parsed_scribes_with_priority scribes_flat_list
  end

  def self.parse_scribes_definition(scribes_definition)
    scribes_definition.items.flat_map { |scribe_definition| self.parse_scribe_definition scribe_definition }
  end

  def self.parse_scribe_definition(scribe_definition)
    context = { default: scribe_definition.default? }
    scribe_definition.groups.flat_map { |group| self.parse_scribe_directive_group(group, context) }
  end

  def self.parse_scribe_directive_group(directive_group, context)
    context[:verb] = directive_group.verb.value
    directive_group.directives.map { |directive| self.parse_scribe_directive(directive, context) }
  end

  def self.parse_scribe_directive(directive, context)
    Directive.new(context[:verb]) do |obj|
      obj.default = context[:default]

      obj.option = directive.option.value
      obj.parameter = directive.parameter.value unless directive.parameter.nil?
    end
  end

  def self.flatten_parsed_scribes_with_priority(scribes_flat_list)
    []
  end

  def self.resolve_references(classes)

  end

  def self.to_objc(interfaces_definitions)
    classes = interfaces_definitions.flat_map { |interface_definition| self.parse_interfaces_definition(interface_definition) }
    self.resolve_references classes
  end
end

module Objc
  class Class
    attr_accessor :scribes
  end

  class Property
    attr_accessor :scribes
  end
end