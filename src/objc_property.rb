require_relative 'objc'

module Objc
  class Property
    def initialize
      @options = []
      @type = nil
      @builder_type = nil
      yield(self) if block_given?
    end

    attr_accessor :name

    def type=(value)
      @type = value
    end

    def type
      @type.nullability = self.extract_option(%i[ nullable nonnull ]) unless @type.nullability
      @type
    end

    def builder_type
      if @builder_type.nil?
        @builder_type = @type.clone
        @builder_type.nullability = self.extract_option(%i[ nullable nonnull ]).nil? ? nil : :nullable
      end
      @builder_type
    end

    def options
      @options
    end

    def options=(value)
      @options = coerce_options value
    end

    def reference_type?
      @type.reference_type?
    end

    def validate?
      self.scribes.should %i[ implement validator ]
    end

    def readonly?
      @options.include? :readonly
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
