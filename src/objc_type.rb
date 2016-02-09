module Objc
  class Type
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