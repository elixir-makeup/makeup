defmodule MakeupTest.LexerTest do
  use ExUnit.Case, async: true
  import ExUnitProperties
  alias Makeup.Lexer
  alias MakeupTest.Lexer.LexerStreamDataGenerators, as: Gen
  alias StreamData

  describe "unlex" do
    test "unlex single token" do
      assert Lexer.unlex([{:x, %{}, "abc"}]) == "abc"
    end

    test "unlex multiple tokens" do
      tokens = [
        {:a, %{}, "abc"},
        {:b, %{}, "def"}
      ]

      assert Lexer.unlex(tokens) == "abcdef"
    end
  end

  describe "split into lines" do
    test "after splitting, token values contain no newline characters" do
      check all tokens <- Gen.tokens() do
        lines = Lexer.split_into_lines(tokens)
        # Lines are lists of tokens
        assert Enum.all?(lines, fn line -> is_list(line) end)
        # Tokens
        for line <- lines do
          for {_type, _attrs, value} <- line do
            assert (not String.contains?(value, "\n"))
          end
        end
      end
    end
  end
end