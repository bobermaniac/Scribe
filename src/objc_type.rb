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

    def reference_type?
      self.class.reference_type? @type_string
    end

    def collection_type?
      collection_types = [ Type.array_types, Type.dictionary_types, Type.set_types ].flat_map { |s| s }
      collection_types.include? @base_type
    end

    def array_type?
      Type.array_types.include? @base_type
    end

    def dictionary_type?
      Type.dictionary_types.include? @base_type
    end

    def set_type?
      Type.set_types.include? @base_type
    end

    def block_type?
      Type.block_types.include? @base_type
    end

    def immutable?
      (not self.reference_type?) or Type.immutable_types.include? @base_type
    end

    def to_s
      return @base_type if @generic_subtypes.nil?
      "#{@base_type} of #{@generic_subtypes.join ', '}"
    end

    def self.reference_type?(type)
      return true if type[-1, 1] == '*'
      [ self.reference_types, self.block_types ].any? { |t| t.include? @type_string }
    end

    def coding_method
      return 'Object' if self.reference_type?
      Objc.typename_without_prefix(@type_string).upcase_1l
    end

    def self.immutable_types
      %w[ NSArray\ * NSNumber\ * NSValue\ * NSDictionary\ * NSSet\ * NSString\ * ] + self.block_types
    end

    def self.array_types
      %w[ NSArray\ * NSMutableArray\ * ]
    end

    def self.reference_types
      %w[ id ]
    end

    def self.block_types
      %w[ dispatch_block_t dispatch_function_t dispatch_data_applier_t dispatch_io_handler_t ]
    end

    def self.boxed_types
      %w[ NSNumber\ * NSValue\ * ]
    end

    def self.value_types
      %w[ NSInteger NSUInteger CGRect CGSize CGFloat ]
    end

    def self.dictionary_types
      %w[ NSDictionary\ * NSMutableDictionary\ * ]
    end

    def self.set_types
      %w[ NSSet\ * NSMutableSet\ * ]
    end
  end
end