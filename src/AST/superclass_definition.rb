require_relative 'core'

module Scribe
  class SuperclassDefinition < NONTERMINAL_CLASS
    def class_name
      self.element_of_type Identifier
    end

    def to_s
      "based on #{self.class_name}"
    end
  end
end