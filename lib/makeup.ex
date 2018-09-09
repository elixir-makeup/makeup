defmodule Makeup do
  @moduledoc """
  Syntax highlighting library for code, inspired by Pygments.

  By default, it doesn't include any lexers.
  You must import them separately (even the Elixir lexer).
  """
  alias Makeup.Formatters.HTML.HTMLFormatter
  alias Makeup.Lexers.ElixirLexer
  alias Makeup.Styles.HTML.StyleMap
  alias Makeup.Styles.HTML.Style
  alias Makeup.Pickers
  require StyleMap


  @doc """
  Highlights the given string using the given lexer and formatter.

  By default it highlight the Elixir language using HTML
  """
  def highlight(source, options \\ []) do
    lexer = case options[:lexer] do
      nil -> ElixirLexer
      module when is_atom(module) -> module
      name -> Pickers.pick_lexer!(name)
    end

    lexer_options = case options[:lexer_options] do
      nil -> []
      opts -> opts
    end

    formatter = case options[:formatter] do
      nil -> HTMLFormatter
      module when is_atom(module) -> module
      name -> Pickers.pick_lexer!(name)
    end

    tokens = apply(lexer, :lex, [source, lexer_options])
    apply(formatter, :format_as_binary, [tokens])
  end

  def highlight_inner_html(source, options \\ []) do
    lexer = case options[:lexer] do
      nil -> ElixirLexer
      module when is_atom(module) -> module
      name -> Pickers.pick_lexer!(name)
    end

    lexer_options = case options[:lexer_options] do
      nil -> []
      opts -> opts
    end

    tokens = apply(lexer, :lex, [source, lexer_options])
    apply(HTMLFormatter, :format_inner_as_binary, [tokens])
  end

  @doc """
  Generates a CSS stylesheet for highlighted code for the given style.

  The `css_class` arguments is the top level class for highlighted code.
  For example, if the `css_class` is `"highlight"` (the default), the stylesheet
  has the form:

  ```css
  .highlight .someclass {...}
  .highlight .anotherclass {...}
  ```
  ...
  """
  def stylesheet(style \\ StyleMap.default_style(), css_class \\ "highlight") do
    Style.stylesheet(style, css_class)
  end

end
