require_relative 'core'

module Scribe
  class ClassDefinition < NONTERMINAL_CLASS
    def import_definitions
      parent.parent.child_text_value ImportDefinitions
    end

    def scribe_definitions
      element_of_type ScribeDefinitions
    end

    def class_name
      child_text_value Identifier
    end

    def superclass_name
      definition = elements_of_type SuperclassDefinition
      return 'NSObject' if definition.empty?
      definition.first.child_text_value Identifier
    end

    def property_definitions
      element_of_type PropertyDefinitions
    end
  end
end