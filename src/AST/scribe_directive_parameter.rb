require_relative 'core'

module Scribe
  class ScribeDirectiveParameter < NONTERMINAL_CLASS
    def value
      self.element_of_type(Identifier).value
    end

    def container
      path = self.element_of_type(ScribeDirectiveParameterPath)
      return nil if path.nil?
      path.element_of_type(ImportDefinitionValue).text_value
    end

    def to_s
      return "#{self.value} in #{self.container}" unless self.container.nil?
      self.value
    end
  end
end