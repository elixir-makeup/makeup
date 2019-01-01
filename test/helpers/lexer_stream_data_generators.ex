defmodule MakeupTest.Lexer.LexerStreamDataGenerators do
  @moduledoc false
  alias StreamData
  alias Makeup.Token.Utils, as: TokenUtils

  def biased_character() do
  end

  def token_value() do
    fragments =
      StreamData.frequency([
        {1, StreamData.constant("\n")},
        {2, StreamData.string(:printable, max_length: 32)}
      ])

    fragments
    |> StreamData.list_of(max_length: 3)
    |> StreamData.map(&to_string/1)
  end

  def token_type() do
    StreamData.one_of(TokenUtils.standard_token_types())
  end

  def tokens() do
    token =
      StreamData.tuple({
        token_type(),
        StreamData.constant(%{}),
        token_value()
      })

    StreamData.list_of(token)
  end
end
