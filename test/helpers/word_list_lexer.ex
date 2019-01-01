defmodule MakeupTest.Lexer.Fixtures.WordListLexer do
  @moduledoc false
  import NimbleParsec
  import Makeup.Lexer.Combinators
  @behaviour Makeup.Lexer

  # Words written deliberately in an order that would make
  # a naive implementation return wrong matches
  language = word_from_list(~w(
      c cpp elixir erlang java javascript
    ))

  # Words written deliberately in an order that would make
  # a naive implementation return wrong matches
  letters =
    word_from_list(
      ~w(
      a aa aaa b bb
    ),
      :letters
    )

  root_element_combinator =
    choice([
      language,
      letters
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
