defmodule Makeup.Pickers do
  alias Makeup.Lexers.{ElixirLexer, HTML5Lexer}
  alias Makeup.Formatters.HTML.{HTMLFormatter}

  def pick_lexer!(nil), do: ElixirLexer
  def pick_lexer!("elixir"), do: ElixirLexer
  def pick_lexer!("html5"), do: HTML5Lexer
  def pick_lexer!("html"), do: HTML5Lexer

  def pick_formatter!(nil), do: HTMLFormatter
  def pick_formatter!("html"), do: HTMLFormatter

end