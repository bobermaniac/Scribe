require_relative 'objc_class'
require_relative 'objc_type'
require_relative 'validation'

module Scribe
  class Directive
    attr_accessor :verb
    attr_accessor :option
    attr_accessor :parameter
    attr_accessor :scope
    attr_accessor :path

    def parameter?
      not self.parameter.nil?
    end

    def initialize(scope, verb)
      @verb = verb
      @option = nil
      @parameter = nil
      @scope = scope

      yield(self) if block_given?
    end

    def is(params)
      (verb, option, _) = params
      (self.verb == verb and self.option == option) ? [ self.parameter, self.path ] : false
    end

    def to_s
      "#{self.scope} #{self.verb}: #{self.option}#{self.parameter? ? (' = ' + self.parameter) : ''}"
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

      a_class.scribes = self.parse_scribes({ global: context[:global_scribes], class: context[:class_scribes] })
      a_class.properties = self.parse_properties_definition(interface_definition.properties, context)
    end
  end

  def self.parse_properties_definition(properties_definition, context)
    properties_definition.items.map { |property_definition|  self.parse_property_definition(property_definition, context)}
  end

  def self.parse_property_definition(property_definition, context)
    Objc::Property.new do |a_property|
      a_property.scribes = self.parse_scribes({ global: context[:global_scribes], class: context[:class_scribes], property: property_definition.scribes  })

      a_property.type = self.parse_type property_definition.type
      a_property.options = property_definition.options.items.map { |option| self.parse_option option }
      a_property.name = property_definition.identifier.value
    end
  end

  def self.parse_option(option)
    opt_sym = option.option.value.to_sym
    return opt_sym unless option.option_parameter
    [ opt_sym, option.option_parameter ]
  end

  def self.parse_type(type)
    Objc::Type.new(type.to_s, nil) do |t|
      t.base_type = "#{type.base_type.to_s} #{type.ref? ? '*' : ''}".strip
      t.generic_subtypes = type.generic_type_params.types.map { |t| self.parse_type t } if type.generic?
      t
    end
  end

  def self.parse_scribes(scribes_priority_list)
    scribes_flat_list = scribes_priority_list.flat_map { |scope, scribes_definition| self.parse_scribes_definition(scope, scribes_definition) }
    self.flatten_parsed_scribes_with_priority scribes_flat_list
  end

  def self.parse_scribes_definition(scope, scribes_definition)
    return [] if scribes_definition.nil?
    scribes_definition.items.flat_map { |scribe_definition| self.parse_scribe_definition(scope, scribe_definition) }
  end

  def self.parse_scribe_definition(scope, scribe_definition)
    scribe_definition.groups.flat_map { |group| self.parse_scribe_directive_group(scope, group) }
  end

  def self.parse_scribe_directive_group(scope, directive_group)
    verb = directive_group.verb.value.to_sym
    directive_group.directives.map { |directive| self.parse_scribe_directive(scope, verb, directive) }
  end

  def self.parse_scribe_directive(scope, verb, directive)
    Directive.new(scope, verb) do |obj|
      obj.option = directive.option.value.to_sym
      obj.parameter = directive.parameter.value unless directive.parameter.nil?
      obj.path = directive.parameter.container unless directive.parameter.nil?
    end
  end

  def self.flatten_parsed_scribes_with_priority(scribes_flat_list)
    scribes_flat_list
  end

  def self.resolve_references(classes)
    root = Objc::Class.NSObject
    classes << root

    classes.each do |a_class|
      next if a_class.root?
      next self.warn_nil_ancestor(a_class, root) if a_class.ancestor.nil?
      a_class.ancestor = (classes.select { |c| c.name == a_class.ancestor }.first or a_class.ancestor)
    end

    classes.delete root

    unresolved_ancestors = classes.reject { |c| c.ancestor.is_a? Objc::Class }
    abort unresolved_ancestors.map { |c| "[ERROR] Unresolved ancestor #{c.ancestor} for class #{c.name}" }.join "\n" if unresolved_ancestors.any?

    classes
  end

  def self.warn_nil_ancestor(a_class, root)
    a_class.ancestor = root
    STDERR.puts "[WARNING] No ancestor defined for class #{a_class.name}, did you forget to inherit from NSObject?"
  end

  def self.to_objc(interfaces_definitions)
    classes = interfaces_definitions.flat_map { |interface_definition| self.parse_interfaces_definition(interface_definition) }
    self.resolve_references classes
  end

  def self.default_interfaces
    @@default_interfaces
  end

  def self.default_interfaces=(value)
    @@default_interfaces = value
  end
end

module Objc
  module ScribesSupport
    attr_accessor :scribes

    def should(params)
      result = self.scribes.map{ |s| s.is params }.select { |r| r }
      result = false unless result.any?
      result
    end
  end

  class Class
    include ScribesSupport

    def self.accepted_scribes
      {
          implement: %i[ mutable, builder, archivable ],
          extract: %i[ interface ],
          make: %i[ abstract ]
      }
    end

  end

  class Property
    include ScribesSupport

    def validate?
      self.validators
    end

    def validators
      self.should %i[ implement validator ]
    end

    def self.accepted_scribes
      {
          implement: %i[ validator ],
          hint: {
              kind: %i[ object, value, array, dictionary, set, block, boxed ],
              primitive: nil,
              wrap: nil,
              unwrap: nil,
          },
          synthesize: %i[ default, primitive, extended ]
      }
    end
  end
end