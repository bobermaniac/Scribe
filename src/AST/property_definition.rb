require_relative 'core'

module Scribe
  class PropertyDefinition < NONTERMINAL_CLASS
    def scribe_definitions
      self.element_of_type ScribeDefinitions
    end

    def options
      self.element_of_type PropertyOptions
    end

    def type_definition
      self.element_of_type Type
    end

    def identifier
      self.element_of_type Identifier
    end


    def to_s
      "#{self.scribe_definitions or 'plain'} #{self.options} #{self.type_definition}#{self.identifier}"
    end
  end
end