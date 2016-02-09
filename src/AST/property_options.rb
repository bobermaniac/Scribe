require_relative 'core'

module Scribe
  class PropertyOptions < NONTERMINAL_CLASS
    def items
      self.recursive_elements_of_type PropertyOption
    end

    def to_s
      self.items.join ', '
    end
  end
end