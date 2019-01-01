defmodule MakeupTest.Lexer.Fixtures.TokenLexer do
  @moduledoc false
  import NimbleParsec
  import Makeup.Lexer.Combinators
  @behaviour Makeup.Lexer

  # use a literal binary as an argument
  chris = token("chris", :phoenix_creator)
  # use the string combinator
  grych = token(string("grych"), :drab_creator)
  # set attrbutes
  jose = token("jose", :elixir_creator, %{country: "Brazil"})
  # unicode fun
  josé = token(string("josé"), :elixir_creator, %{country: "Poland"})

  whitespace = ascii_string([?\s], min: 1)

  root_element_combinator =
    choice([
      whitespace,
      chris,
      grych,
      jose,
      josé
    ])

  root_combinator = repeat(root_element_combinator)

  # TODO: the @impl below raises a warning. Investigate why
  # @impl Makeup.Lexer
  defparsec(
    :root,
    root_combinator
  )

  # TODO: the @impl below raises a warning. Investigate why
  # @impl Makeup.Lexer
  defparsec(
    :root_element,
    root_element_combinator
  )

  @impl Makeup.Lexer
  def postprocess(tokens, _options \\ []), do: tokens

  @impl Makeup.Lexer
  def match_groups(tokens, _options \\ []), do: tokens

  @impl Makeup.Lexer
  def lex(text, _options \\ []) do
    {:ok, tokens, "", _, _, _} = root(text)
    tokens
  end
end
