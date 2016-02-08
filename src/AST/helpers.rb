module Scribe
  class Treetop::Runtime::SyntaxNode
    protected
    def elements_of_type(type)
      return [] if self.elements.nil?
      self.elements.select { |item| item.is_a? type }
    end

    def element_of_type(type)
      e = elements_of_type type
      throw "Too much #{type} in #{self.class}" if e.count > 1
      return nil unless e.any?
      e.first
    end

    def self.recursive_elements_of_type(elements, type)
      return [] if elements == nil

      elements.flat_map do |element|
        next [ element ] if element.is_a? type
        next [] if element.is_a? Scribe::TERMINAL_CLASS
        recursive_elements_of_type(element.elements, type)
      end
    end

    def recursive_elements_of_type(type)
      self.class.recursive_elements_of_type(self.elements, type)
    end

    def child_text_value(type)
      children = elements_of_type type
      return [] if children.count == 0
      raise "Invalid children count of #{type} for #{self.class}" unless children.count == 1
      children.first.text_value
    end
  end
end