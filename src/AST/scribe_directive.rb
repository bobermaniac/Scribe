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
      "#{self.directive}=#{self.parameter}" unless self.parameter.nil?
      "#{self.directive}"
    end
  end
end