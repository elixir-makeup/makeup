defmodule Makeup.Lexer do
  
  def merge([{tag, meta, value1}, {tag, meta, value2} | rest]),
    do: merge [{tag, meta, value1 <> value2} | rest]
  def merge([token | rest]),
    do: [token | merge(rest)]
  def merge([]),
    do: []

  def unlex(tokens) do
    tokens
    |> Enum.map(fn {_, _, value} -> value end)
    |> Enum.join("")
  end

end