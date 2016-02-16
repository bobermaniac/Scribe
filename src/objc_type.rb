require_relative 'objc_known_types'

module Objc
  class Type
    @@markers = {
        nullable: '_Nullable',
        nonnull: '_Nonnull'
    }

    def markers
      @@markers
    end

    def initialize(type_string, nullability)
      @type_string = type_string.strip
      @nullability = nullability
      @base_type = @type_string
      @generic_subtypes = nil

      yield(self) if block_given?
    end

    attr_accessor :nullability
    attr_accessor :base_type
    attr_accessor :generic_subtypes

    def qualified_string
      return self.unqualified_string if @nullability.nil?
      "#{self.unqualified_string} #{self.markers[@nullability]}"
    end

    def unqualified_string
      @type_string
    end

    def type_traits
      Type.known_types[@base_type] or []
    end

    def reference_type?
      self.type_traits.include? :reference
    end

    def collection_type?
      (self.type_traits & %i[ array dictionary set ordered_set ]).any?
    end

    def array_type?
      self.type_traits.include? :array
    end

    def dictionary_type?
      self.type_traits.include? :dictionary
    end

    def set_type?
      self.type_traits.include? :set
    end

    def block_type?
      self.type_traits.include? :block
    end

    def immutable?
      (self.type_traits & %i[ value immutable ]).any?
    end

    def requires_immutable_copy?
      self.type_traits.include? :immutable_copy
    end

    def to_s
      return @base_type if @generic_subtypes.nil?
      "#{@base_type} of #{@generic_subtypes.join ', '}"
    end

    def coding_method
      return 'Object' if self.reference_type?
      Objc.typename_without_prefix(@type_string).upcase_1l
    end
  end
end