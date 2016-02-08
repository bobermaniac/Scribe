require_relative 'core'

module Scribe
  class ClassDefinitions < NONTERMINAL_CLASS
    def imports
      self.element_of_type ImportDefinitions
    end

    def scribes_defaults
      self.element_of_type ScribeDefinitions
    end

    def interfaces
      self.elements.flat_map { |item| item.elements_of_type ClassDefinition }
    end

    def to_s
      "#{imports}\n#{scribes_defaults}\n#{interfaces.join "\n"}"
    end
  end
end