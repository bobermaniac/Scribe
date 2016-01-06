#! /usr/bin/ruby

require 'rubygems'
require 'treetop'
require 'liquid'
require 'optparse'
require_relative 'objc'
require_relative 'objctemplar_parser'

parameters = { :source => [], :destination => Dir.pwd }

OptionParser.new do |opts|
  opts.banner = "Usage: objctemplar.rb [options]"
  opts.on('-s [ARG]', '--source [ARG]', "Source files") do |v|
    parameters[:source] += [ v ]
  end
  opts.on('-d [ARG]', '--destination [ARG]', "Destination folder (default = working directory)") do |v|
    parameters[:destination] = v
  end
  opts.on('--version', 'Display the version') do
    puts "objctemplar.rb version 0.1a"
    exit
  end
  opts.on('-h', '--help', 'Display this help') do
    puts opts
    exit
  end
end.parse!

header_template = Liquid::Template.parse(IO.read 'objc_header.template')
source_template = Liquid::Template.parse(IO.read 'objc_source.template')

Treetop.load 'objc_grammar'
parser = MythGeneratorParser.new

results = parameters[:source].map { |s| parser.parse(IO.read s) }

if results.include? nil
  puts parser.failure_reason
else
  classes_raw = results.flat_map { |result| result.classes }
  classes = [ Objc::Class.NSObject ]

  while classes_raw.any?
    ancestor = classes.last
    descendants = classes_raw.select { |class_raw| class_raw.superclass_name == ancestor.name }
    classes_raw -= descendants
    classes += descendants.map do |class_raw|
      Objc::Class.new(class_raw.class_name, ancestor) do |cls|
        cls.supports = class_raw.supports
        cls.properties = class_raw.properties.map do |property_raw|
          Objc::Property.new do |property|
            property.type = property_raw.type_name
            property.name = property_raw.name
            property.options = property_raw.options
          end
        end
      end
    end
  end

  for cls in classes.reject { |c| c.root? }
    File.open("#{parameters[:destination]}/#{cls.name}.h", 'w') do |header|
      header.write(header_template.render 'class' => cls)
    end
    File.open("#{parameters[:destination]}/#{cls.name}.m", 'w') do |source|
      source.write(source_template.render 'class' => cls)
    end
  end
end