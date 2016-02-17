module Scribe
  def self.validate_classes(classes)
    failed_validators = self.validators.map { |c| [c, c.new.validate_classes(classes)] }.reject { |(_, r)| r }
    return true if failed_validators.none?
    STDERR.puts "Failed validators:\n\t#{failed_validators.map{ |c, _| c }.join "\n\t"}"
    false
  end

  def self.validators
    [
        NonnullPropertyOnlyCouldBeReadonlyValidator,
        ShouldUseOnlyImmutableTypesForPropertiesValidator,
        ClassCouldNotBeSerializableWithBlockPropertiesValidator,
        ShouldNotUseCopyPropertyOptionValidator,
    ]
  end

  class Validator
    def validate_classes(classes)
      true
    end

    def all_properties_should_satisfy(classes)
      abort "Internal error: No block given for validator #{self.class}" unless block_given?
      vr = classes.flat_map do |a_class|
        a_class.properties.map do |a_prop|
          yield(a_class, a_prop)
        end
      end
      vr.all?
    end
  end

  class NonnullPropertyOnlyCouldBeReadonlyValidator < Validator
    def validate_classes(classes)
      self.all_properties_should_satisfy(classes) do |a_class, a_prop|
        next true unless a_prop.type.nullability == :nonnull
        unless a_prop.reference_type? and a_prop.readonly?
          STDERR.puts "[ERROR] Property `#{a_prop.name}` of class `#{a_class.name}` marked as nonnull but this contract could be satisfied only if property marked as readonly. Generated classes have no default property initializers and property will be set to default (nil) value after designated initializer was called. You should mark property as readonly or remove nonnull type hint."
          next false
        end
        next true
      end
    end
  end

  class ShouldUseOnlyImmutableTypesForPropertiesValidator < Validator
    def validate_classes(classes)
      self.all_properties_should_satisfy(classes) do |a_class, a_prop|
        next true if a_prop.type.immutable?
        STDERR.puts "[ERROR] Property `#{a_prop.name}` of class `#{a_class.name}` have type #{a_prop.type.qualified_string} which is not guaranteed to be immutable. Using of mutable types breaks immutable class contract. You have to avoid using this type. If you sure that this type is immutable use `hint immutable` to declare it in explicit way"
        next false
      end
    end
  end

  class ShouldNotUseCopyPropertyOptionValidator < Validator
    def validate_classes(classes)
      self.all_properties_should_satisfy(classes) do |a_class, a_prop|
        next true unless a_prop.options.include? :copy
        STDERR.puts "[WARNING] Property `#{a_prop.name}` of class `#{a_class.name}` marked as 'copy'. That is redundant. In fact property semantic will be made by Scribe is more complicated and contains immutable deep copying of objects. You should use 'retain' for properties to make definition more clear and understandable."
        next true
      end
    end
  end

  class ShouldAllowImmutableCopySemanticsForAllPropertyTypesValidator < Validator
    def validate_classes(classes)
      self.all_properties_should_satisfy(classes) do |a_class, a_prop|
        next true
      end
    end
  end

  class ClassCouldNotBeSerializableWithBlockPropertiesValidator < Validator
    def validate_classes(classes)
      self.all_properties_should_satisfy(classes) do |a_class, a_prop|
        next true unless a_class.should %i[ implement archivable ]
        next true unless a_prop.type.block_type?
        STDERR.puts "[ERROR] Class `#{a_class.name}` requires to be persistent via NSCoding protocol implementation but it have property `#{a_prop.name}` which have block type. Block types can't be serialized via NSKeyedArchiver. You should remove 'archivable' annotation or avoid using block property types for serializable class."
        next false
      end
    end
  end
end