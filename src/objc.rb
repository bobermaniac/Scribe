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

  def self.parse_class_definitions(classes_definitions)
    classes_definitions.map do |class_definitions|
      context = { defaults: class_definitions.scribes_defaults, imports: class_definitions.imports }
      class_definitions.interfaces.map do |class_definition|
        self.parse_class_definition(class_definition, context)
      end
    end
  end

  def self.parse_class_definition(class_definition, context)
    Class.new do |a_class|

    end
  end

  def self.resolve_references(classes)

  end

  def self.from_scribe(scribe_classes)
    classes = self.parse_class_definitions scribe_classes
    self.resolve_references classes
  end
end