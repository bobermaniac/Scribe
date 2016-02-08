require_relative 'core'

module Scribe
  class ScribeDirective < NONTERMINAL_CLASS
    def directive
      self.element_of_type Identifier
    end

    def parameter
      self.element_of_type ScribeDirectiveParameter
    end

    def to_s
      "#{self.directive} parameter:#{self.parameter}"
    end
  end
end