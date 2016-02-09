require_relative 'core'

module Scribe
  class InterfacesDefinition < NONTERMINAL_CLASS
    def imports
      self.element_of_type ImportsDefinition
    end

    def scribes
      self.element_of_type ScribesDefinition
    end

    def interfaces
      self.elements.flat_map { |item| item.elements_of_type InterfaceDefinition }
    end

    def to_s
      "#{imports}\n#{scribes}\n#{interfaces.join "\n"}"
    end
  end
end