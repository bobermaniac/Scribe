require_relative 'helpers'

module Scribe
  public
  BASE_CLASS = Treetop::Runtime::SyntaxNode

  def self.define_classes(names, base = BASE_CLASS)
    names.map { |a_class| define_class(a_class) }
  end

  def self.define_class(name, base = BASE_CLASS)
    a_class = Class.new(base) { |_| }
    Scribe.const_set(name, a_class)
    a_class
  end

  # Terminals:
  TERMINAL_CLASS = define_class('Terminal')

  # Whitespace
  define_class('Whitespace', TERMINAL_CLASS)

  # Punctiation
  define_classes(%w(LeftParenthesis RightParenthesis LeftBroket RightBroket Semicolon Colon Comma Asterisk EqualsSign), TERMINAL_CLASS)

  # Keywords
  define_classes(%w(Interface End Property Scribe Import Default).map { |w| w + 'Keyword' }, TERMINAL_CLASS)

  # Custom tokens
  define_classes(%w(ScribeDefaultsMarker Identifier), TERMINAL_CLASS)

  # Nonterminals:
  NONTERMINAL_CLASS = define_class('Nonterminal')
end