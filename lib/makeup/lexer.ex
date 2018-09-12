defmodule Makeup.Lexer do
  @moduledoc """
  A lexer turns raw source code into a list of tokens.
  """
  alias Makeup.Lexer.Types, as: T

  @doc """
  Parses the smallest number of tokens that make sense.
  It's a `parsec`.
  """
  @callback root_element(String.t) :: T.parsec_result

  @doc """
  Parses the given string into a `parsec` result that inludes a list of tokens.
  """
  @callback root(String.t) :: T.parsec_result

  @doc """
  Postprocesses a list of tokens before matching the contained groups.
  """
  @callback postprocess([T.token()], list()) :: [T.token()]

  @doc """
  Matches groups in a list of tokens.
  """
  @callback match_groups([T.token()], String.t) :: [T.token()]

  @doc """
  Lexes a string into a list of tokens
  """
  @callback lex(String.t(), list()) :: [T.token()]
end
