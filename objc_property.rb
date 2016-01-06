require_relative 'objc'

module Objc
  class Property
    def initialize
      yield(self) if block_given?
    end

    attr_accessor :options
    attr_accessor :name
    attr_accessor :type

    def type_qualified
      return "#{type} _Nonnull" if options.include? :nonnull
      return "#{type} _Nullable" if options.include? :nullable
      type
    end
  end
end
