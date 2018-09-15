defmodule MakeupTest.Lexer.CombinatorsTest do
  use ExUnit.Case, async: true
  alias MakeupTest.Lexer.Fixtures.TokenLexer
  alias MakeupTest.Lexer.Fixtures.WordListLexer

  describe "tokens" do
    test "token with string literal" do
      assert TokenLexer.lex("chris") == [
        {:phoenix_creator, %{}, "chris"}
      ]
    end

    test "token with string combinator" do
      assert TokenLexer.lex("grych") == [
        {:drab_creator, %{}, "grych"}
      ]
    end

    test "token with attrs" do
      assert TokenLexer.lex("jose") == [
        {:elixir_creator, %{country: "Brazil"}, "jose"}
      ]
    end

    test "unicode fun" do
      assert TokenLexer.lex("josé") == [
        {:elixir_creator, %{country: "Poland"}, "josé"}
      ]
    end
  end

  describe "word_from_list" do
    test "without token - match the longest word" do
      # results won't be valid token lists
      assert WordListLexer.lex("c") == ["c"]
      assert WordListLexer.lex("cpp") == ["cpp"]
      assert WordListLexer.lex("elixir") == ["elixir"]
      assert WordListLexer.lex("erlang") == ["erlang"]
      assert WordListLexer.lex("java") == ["java"]
      assert WordListLexer.lex("javascript") == ["javascript"]
      # Doesn't match anything else
      assert_raise MatchError, fn ->
        WordListLexer.lex("other")
      end
    end

    test "with token - match the longest word" do
      assert WordListLexer.lex("a") == [{:letters, %{}, "a"}]
      assert WordListLexer.lex("aa") == [{:letters, %{}, "aa"}]
      assert WordListLexer.lex("aaa") == [{:letters, %{}, "aaa"}]
      assert WordListLexer.lex("b") == [{:letters, %{}, "b"}]
      assert WordListLexer.lex("bb") == [{:letters, %{}, "bb"}]
      # Doesn't match anything else
      assert_raise MatchError, fn ->
        WordListLexer.lex("other")
      end
    end
  end
end