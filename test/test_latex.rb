require File.expand_path(File.dirname(__FILE__) + "/test_helper")

module Undress
  class TestLatex < Test::Unit::TestCase
    def assert_renders_latex(latex, html)
      assert_equal latex, Undress(html).to_latex
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

      test "multiple tags at the same time" do
        assert_renders_latex "\\textbf{\\emph{italic bold}}\n\n", "<p><strong><em>italic bold</em></strong></p>" 
      end
    end



  end
end
