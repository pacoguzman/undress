require File.expand_path(File.dirname(__FILE__) + "/../undress")

module Undress
  class Latex < Grammar

    rule_for(:p) do |e|
      if e.has_attribute?("style") && e["style"] =~ /text-align:/
        case e["style"][/text-align:\s?(\w+)/, 1]
          when "right"
            "\\begin{flushright}#{content_of(e)}\n\\end{flushright}\n"
          when "left"
            "\\begin{flushleft}#{content_of(e)}\n\\end{flushleft}\n"
          when "center"
           "\\begin{center}#{content_of(e)}\n\\end{center}\n"
          else
            "#{content_of(e)}\n\n"
        end
      else
        "#{content_of(e)}\n\n"
      end
    end
    rule_for(:strong) {|e| "\\textbf{#{content_of(e)}}"}
    rule_for(:em) {|e| "\\emph{#{content_of(e)}}"}
    rule_for(:br) {|e| "\\newline\n"}

    rule_for(:ul) {|e| "\\begin{itemize}#{content_of(e)}\n\\end{itemize}\n"}
    rule_for(:ol) {|e| "\\begin{enumerate}#{content_of(e)}\n\\end{enumerate}\n"}
    rule_for(:li) {|e| "\n\\item{#{content_of(e)}}"}

    # inline elements
    rule_for(:span) do |e|
      if e.has_attribute?("style") && e["style"] =~ /text-decoration:\s?underline/
        "\\underline{#{content_of(e)}}"
      else
        "#{content_of(e)}"
      end
    end
  end

  add_markup :latex, Latex
end