require_relative 'objc_class'
require_relative 'objc_property'
require_relative 'objc_class_drop'
require_relative 'objc_property_drop'

module Objc
  def self.prefix_for_typename(typename)
    result = typename.match(/[A-Z][A-Z0-9]+/)
    return result.to_s.chop unless result == nil
    ''
  end

  def self.typename_without_prefix(typename)
    typename[prefix_for_typename(typename).length..-1]
  end
end