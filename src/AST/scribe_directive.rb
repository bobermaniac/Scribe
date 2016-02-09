require_relative 'core'

module Scribe
  class ScribeDirective < NONTERMINAL_CLASS
    def option
      self.element_of_type Identifier
    end

    def parameter
      self.element_of_type ScribeDirectiveParameter
    end

    def to_s
      "#{self.option}=#{self.parameter}" unless self.parameter.nil?
      "#{self.option}"
    end
  end
end