require_relative 'objc'

module Objc
  class Property
    def initialize
      @options = []

      yield(self) if block_given?
    end

    attr_accessor :name
    attr_accessor :type

    def options
      @options
    end

    def options=(value)
      @options = coerce_options value
    end

    def reference_type?
      self.type.include? '*'
    end

    def coerce_options(options)
      self.coerce_option(options, %i[ atomic nonatomic ], :atomic)
      self.coerce_option(options, %i[ strong weak ], self.reference_type? ? :strong : nil)
      self.coerce_option(options, %i[ assign copy retain ], self.reference_type? ? :retain : :assign)
      self.coerce_option(options, %i[ readwrite, readonly ], :readwrite)
      self.coerce_option(options, %i[ nonnull nullable ], self.reference_type? ? :nullable : nil)
    end

    def coerce_option(options, alternatives, default)
      return options if default.nil?
      options << default unless alternatives.any? { |s| options.include? s }
      options
    end

    def type_qualified
      return "#{type} _Nonnull" if options.include? :nonnull
      return "#{type} _Nullable" if options.include? :nullable
      type
    end

    def builder_type_qualified
      return "#{type} _Nullable" if (options.include?(:nullable) or options.include?(:nonnull))
      type
    end

  end
end
