module Objc
  class Type
    @@known_types = nil

    def self.known_types
      return @@known_types unless @@known_types.nil?
      @@known_types = {
          # Reference types
          'id' => %i[ reference mutable ],
          'NSObject *' => %i[ reference immutable ],
          'dispatch_block_t' => %i[ reference block immutable copy ],
          'dispatch_function_t' => %i[  reference block immutable copy ],
          'dispatch_data_applier_t' => %i[ reference block immutable copy ],
          'dispatch_io_handler_t' => %i[ reference block immutable copy ],
          'NSValue *' => %i[ reference number immutable copy ],
          'NSNumber *' => %i[ reference number immutable copy ],
          'NSDecimalNumber *' => %i[ reference number immutable copy ],
          'NSString *' => %i[ reference string immutable copy immutable_copy mutable_copy ],
          'NSMutableString *' => %i[ reference string mutable copy immutable_copy mutable_copy ],
          'NSArray *' => %i[ reference array immutable copy immutable_copy mutable_copy ],
          'NSMutableArray *' => %i[ reference array mutable copy immutable_copy mutable_copy ],
          'NSSet *' => %i[ reference set immutable copy immutable_copy mutable_copy ],
          'NSMutableSet *' => %i[ reference set mutable copy immutable_copy mutable_copy ],
          'NSOrderedSet *' => %i[ reference ordered_set immutable copy immutable_copy mutable_copy ],
          'NSMutableOrderedSet *' => %i[ reference ordered_set mutable copy immutable_copy mutable_copy ],
          'NSDictionary *' => %i[ reference dictionary immutable copy immutable_copy mutable_copy ],
          'NSMutableDictionary *' => %i[ reference dictionary mutable copy immutable_copy mutable_copy ],
          'NSData *' => %i[ reference immutable copy immutable_copy mutable_copy ],
          'NSMutableData *' => %i[ reference mutable copy immutable_copy mutable_copy ],
          'NSDate *' => %i[ reference immutable ],
          'UIFont *' => %i[ reference immutable ],

          # Value types
          'NSInteger' => %i[ value ],
          'NSUInteger' => %i[ value ],
          'NSDecimal' => %i[ value ],
          'NSRange' => %i[ value ],
          'NSTimeInterval' => %i[ value ],
          'CGRect' => %i[ value ],
          'CGSize' => %i[ value ],
          'CGFloat' => %i[ value ],
          'UIEdgeInsets' => %i[ value ],
          'int' => %i[ value ],
          'long' => %i[ value ],
          'float' => %i[ value ],
          'double' => %i[ value ],
      }
    end
  end
end