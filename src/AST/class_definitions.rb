require_relative 'core'

module Scribe
  class ClassDefinitions < NONTERMINAL_CLASS
    def global_scribes
      []
    end

    def classes
      self.elements.flat_map { |item| item.children_of_type InterfaceDefinition  }
    end
  end
end