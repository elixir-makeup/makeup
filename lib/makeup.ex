defmodule Makeup do
  alias Makeup.Formatters.HTML.SimpleHTMLFormatter
  alias Makeup.Lexers.ElixirLexer

  alias Makeup.Styles.HTML.StyleMap
  require StyleMap

  @doc """
  Highlights the given string using the given lexer and formatter.

  By default it highlight the Elixir language using HTML
  """
  def highlight(source, lexer \\ ElixirLexer, formatter \\ SimpleHTMLFormatter) do
    tokens = apply(lexer, :lex, [source])
    apply(formatter, :format, [tokens])
  end

  @doc """
  Generates a CSS stylesheet for highlighted code for the given style.

  The `css_class` arguments is the top level class for highlighted code.
  For example, if the `css_class` is `"highlight"` (the default), the stylesheet
  has the form:
  
      .highlight .someclass {...}
      .highlight .anotherclass {...}
      ...
  """
  def stylesheet(style \\ StyleMap.default, css_class \\ "highlight") do
    Makeup.Styles.HTML.Style.stylesheet(style, css_class)
  end

end