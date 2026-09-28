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

  describe "merge" do
    test "merges adjacent tokens of the same type and attributes" do
      tokens = [{:a, %{}, "ab"}, {:a, %{}, "cd"}, {:b, %{}, "ef"}]

      assert [{:a, %{}, value}, {:b, %{}, "ef"}] = Lexer.merge(tokens)
      assert IO.iodata_to_binary(value) == "abcd"
    end

    test "does not merge tokens with different attributes" do
      tokens = [{:a, %{x: 1}, "ab"}, {:a, %{x: 2}, "cd"}]

      assert Lexer.merge(tokens) == tokens
    end

    test "merges iodata token values" do
      tokens = [{:a, %{}, ["a", "b"]}, {:a, %{}, "cd"}]

      assert [{:a, %{}, value}] = Lexer.merge(tokens)
      assert IO.iodata_to_binary(value) == "abcd"
    end

    test "merging preserves the unlexed string" do
      tokens = [{:a, %{}, ["a", "b"]}, {:a, %{}, ["c", ["d"]]}, {:b, %{}, "e"}]

      assert tokens |> Lexer.merge() |> Lexer.unlex() == "abcde"
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