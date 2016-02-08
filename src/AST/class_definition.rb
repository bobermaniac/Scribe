require_relative 'core'

module Scribe
  class ClassDefinition < NONTERMINAL_CLASS
    def import_definitions
      parent.parent.child_text_value ImportDefinitions
    end

    def scribe_definitions
      element_of_type ScribeDefinitions
    end

    def class_name_definition
      child_text_value Identifier
    end

    def superclass_definition
      self.element_of_type SuperclassDefinition
    end

    def property_definitions
      element_of_type PropertyDefinitions
    end

    def to_s
      "#{self.scribe_definitions}\nclass #{self.class_name_definition} #{self.superclass_definition} {\n#{self.property_definitions}\n}"
    end
  end
end