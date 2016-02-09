require_relative 'core'

module Scribe
  class PropertyDefinition < NONTERMINAL_CLASS
    def scribes
      self.element_of_type ScribesDefinition
    end

    def options
      self.element_of_type PropertyOptions
    end

    def type
      self.element_of_type Type
    end

    def identifier
      self.element_of_type Identifier
    end

    def to_s
      "#{self.scribes or 'plain'} #{self.options} #{self.type}#{self.identifier}"
    end
  end
end