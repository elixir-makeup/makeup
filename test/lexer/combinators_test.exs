defmodule MakeupTest.Lexer.CombinatorsTest do
  use ExUnit.Case, async: true

  alias MakeupTest.Lexer.Fixtures.TokenLexer
  alias MakeupTest.Lexer.Fixtures.WordListLexer

  import NimbleParsec
  import Makeup.Lexer.Combinators

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

  test "unicode" do
    assert TokenLexer.lex("áò") == [{:character_lexeme, %{}, "áò"}]
    # A previous version had the following wrong output:
    refute TokenLexer.lex("áò") == [{:character_lexeme, %{}, <<225, 242>>}]
  end

  describe "string_like" do
    defparsecp(:sl_empty, string_like("--", "--", [], :comment))
    defparsecp(:sl_not_empty, string_like("--", "--", [string("code")], :comment))

    test "empty middle" do
      assert {:ok, [{:comment, %{}, ["--", ?c, ?o, ?d, ?e, "--"]}], "", _, _, _} =
               sl_empty("--code--")
    end

    test "non-empty middle" do
      assert {:ok, [{:comment, %{}, ["--", ?!, "code", ?!, "--"]}], "", _, _, _} =
               sl_not_empty("--!code!--")
    end
  end

  describe "many_surrounded_by" do
    defparsecp(:comment_tag, many_surrounded_by(utf8_char([]), "<!--", "-->"))

    defparsecp(
      :comment_tag_no_eos,
      many_surrounded_by(utf8_char([]), "<!--", "-->", eos: false, ttype: :custom)
    )

    defparsecp(
      :with_combinators,
      many_surrounded_by(
        utf8_char([]),
        choice([string("{"), string("[")]),
        choice([string("}"), string("]")])
      )
    )

    test "includes eos by default" do
      assert {:ok, [{:punctuation, %{}, "<!--"}, 104, 101, 108, 108, 111], "", %{}, {1, 0}, 9} =
               comment_tag("<!--hello")

      assert {:error, "expected string \"-->\"", "", %{}, {1, 0}, 9} =
               comment_tag_no_eos("<!--hello")
    end

    test "can override ttype" do
      assert {:ok, [{:custom, %{}, "<!--"}, 104, 101, 108, 108, 111, {:custom, %{}, "-->"}], "",
              %{}, {1, 0},
              12} =
               comment_tag_no_eos("<!--hello-->")
    end

    test "left and right can be complex combinators" do
      assert {:ok, ["[", 104, 101, 108, 108, 111, "}"], "", %{}, {1, 0}, 7} =
               with_combinators("[hello}")
    end
  end
end
