defmodule Makeup.Lexer.Postprocess do
  @moduledoc """
  TODO
  """

  @doc """
  TODO
  """
  def invert_word_map(pairs) do
    nested =
      for {ttype, words} <- pairs do
        for word <- words, do: {word, ttype}
      end

    nested
    |> List.flatten()
    |> Enum.into(%{})
  end

  @doc """
  Converts the value of a token into a binary.

  Token values are usually iolists for performance reasons.
  The BEAM is actually quite fast at printing or concatenating iolists,
  and some of the basic combinators output iolists, so there is no need
  to convert the token values into binaries.

  This function should only be used for tesring purposes, when you might
  want to compare the token list into a reference output.

  Converting the tokens into binaries has two advantges:
  1. It's much easier to compare tokens by visual inspection when the value is a binary
  2. When testing, two iolists that print to the same binary should be considered equal.
  """
  def token_value_to_binary({ttype, meta, value}) do
    {ttype, meta, IO.iodata_to_binary(value)}
  end

  @doc """
  Converts the values of a the tokens in the list into binaries.

  Token values are usually iolists for performance reasons.
  The BEAM is actually quite fast at printing or concatenating iolists,
  and some of the basic combinators output iolists, so there is no need
  to convert the token values into binaries.

  This function should only be used for tesring purposes, when you might
  want to compare the token list into a reference output.

  Converting the tokens into binaries has two advantges:
  1. It's much easier to compare tokens by visual inspection when the value is a binary
  2. When testing, two iolists that print to the same binary should be considered equal.
  """
  def token_values_to_binaries(tokens) do
    Enum.map(tokens, &token_value_to_binary/1)
  end
end
