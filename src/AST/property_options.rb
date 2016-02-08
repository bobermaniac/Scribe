require_relative 'core'

module Scribe
  class PropertyOptions < NONTERMINAL_CLASS
    def definitions
      self.recursive_elements_of_type PropertyOption
    end

    def to_s
      self.definitions.join ', '
    end
  end
end