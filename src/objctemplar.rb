#! /usr/bin/ruby

require 'rubygems'
require 'treetop'
require 'liquid'
require 'optparse'
require_relative 'objc'
require_relative 'scribe'
require_relative 'objctemplar_parser'
require_relative 'AST/scribe'

parameters = { :source => [], :destination => Dir.pwd }

OptionParser.new do |opts|
  opts.banner = "Usage: objctemplar [options]"
  opts.on('-s [ARG]', '--source [ARG]', "Source files (could be multiple)") do |v|
    parameters[:source] += [ v ]
  end
  opts.on('-d [ARG]', '--destination [ARG]', "Destination folder (default = working directory)") do |v|
    parameters[:destination] = v
  end
  opts.on('--version', 'Display the version') do
    puts "objctemplar version 0.1a"
    exit
  end
  opts.on('-h', '--help', 'Display this help') do
    puts opts
    exit
  end
end.parse!

def sanitize(input)
  input.gsub!(/\/\/[^\n]*\n/, ' ')
  input.gsub!(/\/\*.*?\*\//, ' ')
  input
end

header_template = Liquid::Template.parse(IO.read 'src/objc_header.template')
source_template = Liquid::Template.parse(IO.read 'src/objc_source.template')

parser_class = Treetop.load 'src/objc_grammar'
parser = parser_class.new

results = parameters[:source].map do |s|
  result = parser.parse(sanitize IO.read s)
  puts result
  abort "Error processing file #{s}: #{parser.failure_reason}" if result.nil?
  result
end

if results.include? nil
  abort parser.failure_reason
else
  classes_raw = results.flat_map { |result| result.classes }
  classes = [ Objc::Class.NSObject ]
  ancestors = classes

  while classes_raw.any?
    descendants = classes_raw.select { |class_raw| ancestors.any? { |ancestor| ancestor.name == class_raw.superclass_name } }
    classes_raw -= descendants
    ancestors = descendants.map do |class_raw|
      ancestor = ancestors.first {|cls| cls.name == class_raw.superclass_name}
      Objc::Class.new(class_raw.class_name, ancestor) do |cls|
        cls.supports = class_raw.supports
        cls.imports = class_raw.imports
        cls.scribes = class_raw.scribes.flat_map { |d| d.all_definitions }.map do |scribe_raw|
          Scribe::Definition.new do |scribe|
            scribe.pattern = scribe_raw.pattern
            scribe.parameter = scribe_raw.parameter
          end
        end
        cls.properties = class_raw.properties.map do |property_raw|
          Objc::Property.new do |property|
            property.type = property_raw.type_name
            property.name = property_raw.name
            property.options = property_raw.options
            property.scribes = property_raw.scribes.flat_map { |d| d.all_definitions }.map do |scribe_raw|
              Scribe::Definition.new do |scribe|
                scribe.pattern = scribe_raw.pattern
                scribe.parameter = scribe_raw.parameter
              end
            end
          end
        end
      end
    end
    classes += ancestors
  end

  classes = classes.reject { |c| c.root? }
  for cls in classes
    other_classes = classes.reject { |c| c == cls }
    File.open("#{parameters[:destination]}/#{cls.name}.h", 'w') do |header|
      header.write(header_template.render 'class' => cls, 'other_classes' => other_classes.map { |cls| cls.name } )
    end
    File.open("#{parameters[:destination]}/#{cls.name}.m", 'w') do |source|
      source.write(source_template.render 'class' => cls, 'other_classes' => other_classes.map { |cls| cls.name })
    end
  end
end