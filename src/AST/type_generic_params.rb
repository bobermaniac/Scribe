require_relative 'core'

module Scribe
  class TypeGenericParams < NONTERMINAL_CLASS
    def types
      self.recursive_elements_of_type Type
    end

    def to_s
      "<#{self.types.join ', '}>"
    end
  end
end