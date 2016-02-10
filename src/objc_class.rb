require_relative 'objc'

module Objc
  class Class
    def initialize(name, ancestor)
      @name = name
      @ancestor = ancestor
      @properties = []
      @scribes = []

      yield(self) if block_given?
    end

    attr_accessor :ancestor

    attr_accessor :name
    attr_accessor :properties
    attr_accessor :scribes

    attr_accessor :imports

    def root?
      name == 'NSObject'
    end

    def first_nontrivial_ancestor
      ancestor = self
      while true
        return ancestor if ancestor.ancestor.root?
        ancestor = ancestor.ancestor
      end
    end

    def all_properties
      return [] if root?

      aClass = self
      all_properties = []

      while true
        all_properties = aClass.properties + all_properties
        return all_properties if aClass.ancestor.root?
        aClass = aClass.ancestor
      end
    end

    def all_mutable_properties
      return all_properties.reject { |property| property.options.include? :readonly }
    end

    def self.NSObject
      Class.new('NSObject', nil)
    end

    def supports
      Enumerator.new do |enumerator|
        enumerator << :mutable_copy if self.should %i[ implement mutable ]
        enumerator << :builder if self.should %i[ implement builder ]
        enumerator << :abstract if self.should %i[ make abstract ]
        enumerator << :extract_interface if self.should %i[ extract interface ]
      end
    end
  end
end
