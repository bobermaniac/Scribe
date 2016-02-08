require_relative 'core'

module Scribe
  class Type < NONTERMINAL_CLASS
    def base_type
      self.element_of_type Identifier
    end

    def generic_type_params
      self.element_of_type TypeGenericParams
    end

    def ref?
      not self.element_of_type(Asterisk).nil?
    end

    def to_s
      "#{self.base_type}#{self.generic_type_params} #{self.ref? ? '*' : ''}"
    end
  end
end