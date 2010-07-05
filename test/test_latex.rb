require File.expand_path(File.dirname(__FILE__) + "/test_helper")

module Undress
  class TestLatex < Test::Unit::TestCase
    def assert_renders_latex(latex, html)
      assert_equal latex, Undress(html).to_latex
    end

    context "enconding" do
      test "with utf-8 by default" do
        assert_renders_latex "\\emph{Itálica}", "<em>Itálica</em>"
      end
    end

    context "Converting HTML to latex" do
      test "converts <p> tags" do
        assert_renders_latex "foo bar\n\n", "<p>foo bar</p>"
      end

      test "converts <strong> tags" do
        assert_renders_latex "\\textbf{foo bar}", "<strong>foo bar</strong>"
      end

      test "converts <em> tags" do
        assert_renders_latex "\\emph{foo bar}", "<em>foo bar</em>"
      end

      test "converts <br> tags" do
        assert_renders_latex "\\newline\n", "<br/>"
      end

      test "converts <span style=\"text-decoration: underline;\"> tags" do
        assert_renders_latex "\\underline{foo bar}", "<span style=\"text-decoration: underline;\">foo bar</span>"
      end

      test "converts unordered list tags" do
        assert_renders_latex "\\begin{itemize}\n\\item{first}\n\\item{second}\n\\end{itemize}\n", "<ul><li>first</li><li>second</li></ul>"
      end

      test "converts ordered list tags" do
        assert_renders_latex "\\begin{enumerate}\n\\item{first}\n\\item{second}\n\\end{enumerate}\n", "<ol><li>first</li><li>second</li></ol>"
      end

      test "multiple tags at the same time" do
        assert_renders_latex "\\textbf{\\emph{italic bold}}\n\n", "<p><strong><em>italic bold</em></strong></p>" 
      end

      context "text alignment" do
        test "convert text align left" do
          assert_renders_latex "\\begin{flushleft}\\textbf{\\emph{italic bold}}\n\\end{flushleft}\n", "<p style=\"text-align: left;\"><strong><em>italic bold</em></strong></p>"
          # Render correctly differents style attributes
          assert_renders_latex "\\begin{flushleft}\\textbf{\\emph{italic bold}}\n\\end{flushleft}\n", "<p style=\"text-align:left;\"><strong><em>italic bold</em></strong></p>"
          assert_renders_latex "\\begin{flushleft}\\textbf{\\emph{italic bold}}\n\\end{flushleft}\n", "<p style=\"text-align:left\"><strong><em>italic bold</em></strong></p>"
          assert_renders_latex "\\begin{flushleft}\\textbf{\\emph{italic bold}}\n\\end{flushleft}\n", "<p style=\"text-align:left; color:#111111\"><strong><em>italic bold</em></strong></p>"
        end

        test "convert text align right" do
          assert_renders_latex "\\begin{flushright}\\textbf{\\emph{italic bold}}\n\\end{flushright}\n", "<p style=\"text-align: right;\"><strong><em>italic bold</em></strong></p>"
        end

        test "convert text align center" do
          assert_renders_latex "\\begin{center}\\textbf{\\emph{italic bold}}\n\\end{center}\n", "<p style=\"text-align: center;\"><strong><em>italic bold</em></strong></p>"
        end
      end
    end

  end
end
