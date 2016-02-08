require_relative 'core'

module Scribe
  class PropertyOption < NONTERMINAL_CLASS
    def option
      self.element_of_type Identifier
    end

    def to_s
      self.option.to_s
    end
  end
end