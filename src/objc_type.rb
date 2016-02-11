module Objc
  class Type
    @@markers = { nullable: '_Nullable', nonnull: '_Nonnull' }

    def markers
      @@markers
    end

    def initialize(type_string, nullability)
      @type_string = type_string
      @nullability = nullability
    end

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

    def self.reference_type?(type)
      return true if type[-1, 1] == '*'
      [ self.reference_types, self.block_types ].any? { |t| t.include? @type_string }
    end

    def self.array_types
      %w[ NSArray NSMutableArray ]
    end

    def self.reference_types
      %w[ id ]
    end

    def self.block_types
      %w[ dispatch_block_t dispatch_function_t dispatch_data_applier_t dispatch_io_handler_t ]
    end

    def self.boxed_types
      %w[ NSNumber NSValue ]
    end

    def self.value_types
      %w[ NSInteger, NSUInteger, CGRect, CGSize, CGFloat ]
    end

    def self.dictionary_types
      %w[ NSDictionary, NSMutableDictionary ]
    end

    def self.set_types
      %w[ NSSet, NSMutableSet ]
    end
  end
end