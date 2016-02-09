require_relative 'objc_class'
require_relative 'objc_property'
require_relative 'objc_class_drop'
require_relative 'objc_property_drop'

module Objc
  def self.prefix_for_typename(typename)
    result = typename.match(/[A-Z][A-Z0-9]+/)
    return result.to_s.chop unless result == nil
    ''
  end

  def self.typename_without_prefix(typename)
    typename[prefix_for_typename(typename).length..-1]
  end

  def self.parse_interfaces_definition(interfaces_definition)
    context = { global_scribes: interfaces_definition.scribes, imports: interfaces_definition.imports }
    interfaces_definition.interfaces.map do |interface_definition|
      self.parse_interface_definition(interface_definition, context)
    end
  end

  def self.parse_interface_definition(interface_definition, context)
    name = interface_definition.class_name.value
    superclass_name = interface_definition.superclass_name.class_name.value
    Class.new(name, superclass_name) do |a_class|
      context[:class_scribes] = interface_definition.scribes

      a_class.scribes = self.parse_scribes([ context[:global_scribes], context[:class_scribes] ])
      a_class.properties = self.parse_properties_definition(class_definition.properties, context)
    end
  end

  def self.parse_properties_definition(properties_definition, context)

  end

  def self.parse_scribes(scribes_priority_list)
    
  end

  def self.resolve_references(classes)

  end

  def self.from_scribe(interfaces_definitions)
    classes = interfaces_definitions.flat_map { |interface_definition| self.parse_interfaces_definition(interface_definition) }
    self.resolve_references classes
  end
end