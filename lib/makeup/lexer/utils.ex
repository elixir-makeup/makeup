defmodule Makeup.Lexer.Utils do
  @moduledoc """
  Utilities to deal with lexers
  """

  @doc """
  Merge adjacent tokens of the same type and with the same attributes.

  Doing this will require iterating over the list of tokens again,
  so only do this if you have a good reason.
  """
  def merge([{tag, meta, value1}, {tag, meta, value2} | rest]),
    do: merge [{tag, meta, value1 <> value2} | rest]
  def merge([token | rest]),
    do: [token | merge(rest)]
  def merge([]),
    do: []

  @doc """
  Turn a list of tokens into raw text. For any lexer, this should hold true:

  ```elixir
  text |> lexer.lex |> Makeup.Lexer.Utils.unlex() == text
  ```
  """
  def unlex(tokens) do
    tokens
    |> Enum.map(fn {_, _, value} -> value end)
    |> Enum.join("")
  end

end
