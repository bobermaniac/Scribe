require_relative 'core'

module Scribe
  class FilePath < NONTERMINAL_CLASS
    def value
      self.text_value
    end

    def to_s
      self.value
    end
  end
end