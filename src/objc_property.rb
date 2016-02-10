require_relative 'objc'

module Objc
  class Property
    def initialize
      @options = []
      @type = nil
      yield(self) if block_given?
    end

    attr_accessor :name

    def type=(value)
      @type = value
    end

    def type
      return @type if @type.is_a? Objc::Type
      Objc::Type.new(@type, self.extract_option(%i[ nullable nonnull ]))
    end

    def builder_type
      Objc::Type.new(self.type.unqualified_string, self.extract_option(%i[ nullable nonnull ]).nil? ? nil : :nullable)
    end

    def options
      @options
    end

    def options=(value)
      @options = coerce_options value
    end

    def reference_type?
      Objc::Type.reference_type? @type
    end

    def extract_option(opts)
      @options.select { |v| opts.include? v }.first
    end

    def coerce_options(opts)
      self.coerce_option(opts, %i[ atomic nonatomic ], :atomic)
      self.coerce_option(opts, %i[ strong weak ], self.reference_type? ? :strong : nil)
      self.coerce_option(opts, %i[ assign copy retain ], self.reference_type? ? :retain : :assign)
      self.coerce_option(opts, %i[ readwrite, readonly ], :readwrite)
      self.coerce_option(opts, %i[ nonnull nullable ], self.reference_type? ? :nullable : nil)
    end

    def coerce_option(opts, alternatives, default)
      return opts if default.nil?
      opts << default unless alternatives.any? { |s| opts.include? s }
      opts
    end
  end
end
