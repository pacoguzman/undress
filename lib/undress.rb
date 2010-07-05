require "nokogiri"
require File.expand_path(File.dirname(__FILE__) + "/core_ext/object")
require File.expand_path(File.dirname(__FILE__) + "/undress/grammar")

# Load an HTML document so you can undress it. Pass it either a string or an IO
# object.
def Undress(html)
  Undress::Document.new(html)
end

module Undress
  # Register a markup language. The name will become the method used to convert
  # HTML to this markup language: for example registering the name +:textile+
  # gives you <tt>Undress(code).to_textile</tt>, registering +:markdown+ would
  # give you <tt>Undress(code).to_markdown</tt>, etc.
  def self.add_markup(name, grammar)
    Document.add_markup(name, grammar)
  end

  class Document #:nodoc:
    def initialize(html)
      @doc = Nokogiri::HTML(html)
    end

    def self.add_markup(name, grammar)
      define_method "to_#{name}" do
        grammar.process!(@doc % 'body')
      end
    end
  end
end

require File.expand_path(File.dirname(__FILE__) + "/undress/latex")
require File.expand_path(File.dirname(__FILE__) + "/undress/textile")
