require_relative 'objc_class'

module Scribe
  class Definition
    attr_accessor :pattern
    attr_accessor :parameter

    def initialize()
      yield(self) if block_given?
    end
  end
end

module Objc
  class Class
    attr_accessor :scribes
  end

  class Property
    attr_accessor :scribes
  end
end