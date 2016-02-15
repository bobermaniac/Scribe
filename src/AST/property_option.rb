require_relative 'core'

module Scribe
  class PropertyOption < NONTERMINAL_CLASS
    def option
      self.element_of_type Identifier
    end

    def option_parameter
      tail = self.elements.reject { |e| e == self.option }.first
      return nil if tail.nil? or tail.elements.nil? or tail.elements.none?
      content = tail.elements.drop(1)
      content.map { |c| c.text_value }.join ''
    end

    def to_s
      return self.option.to_s unless self.option_parameter
      "#{self.option.to_s} = #{self.option_parameter}"
    end
  end
end