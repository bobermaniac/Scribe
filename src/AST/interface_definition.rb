require_relative 'core'

module Scribe
  class InterfaceDefinition < NONTERMINAL_CLASS
    def scribes
      element_of_type ScribesDefinition
    end

    def class_name
      element_of_type Identifier
    end

    def superclass_name
      self.element_of_type SuperclassDefinition
    end

    def properties
      element_of_type PropertiesDefinition
    end

    def to_s
      "#{self.scribes}\nclass #{self.class_name} #{self.superclass_name} {\n#{self.properties}\n}"
    end
  end
end