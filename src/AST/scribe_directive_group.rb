require_relative 'core'

module Scribe
  class ScribeDirectiveGroup < NONTERMINAL_CLASS
    def verb
      self.element_of_type Identifier
    end

    def directives
      self.recursive_elements_of_type ScribeDirective
    end

    def to_s
      "\n\t\t#{self.verb}: #{self.directives.join ', '}"
    end
  end
end