require File.expand_path(File.dirname(__FILE__) + "/../undress")

module Undress
  class Latex < Grammar

    rule_for(:p)      {|e| "#{content_of(e)}\n\n" }
    rule_for(:strong) {|e| "\\textbf{#{content_of(e)}}"}
    rule_for(:em) {|e| "\\emph{#{content_of(e)}}"}
    rule_for(:br) {|e| "\\newline\n"}

    rule_for(:ul) {|e| "\\begin{itemize}#{content_of(e)}\n\\end{itemize}\n"}
    rule_for(:li) {|e| "\n\\item{#{content_of(e)}}"}

    # inline elements
    rule_for(:span) {|e|
      if e.has_attribute?("style") && e["style"] =~ /text-decoration:\s?underline/
        "\\underline{#{content_of(e)}}"
      else
        "#{content_of(e)}"
      end
    }
  end

  add_markup :latex, Latex
end