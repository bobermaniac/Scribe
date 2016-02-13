require_relative 'core'

module Scribe
  class ImportDefinitionValue < NONTERMINAL_CLASS
    def value
      self.text_value
    end

    def to_s
      "\n\t#{self.value}"
    end
  end
end