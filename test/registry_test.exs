defmodule Makeup.RegistryTest do
  use ExUnit.Case
  alias Makeup.Registry
  doctest Registry

  test "register a lexer and fetch it afterwards" do
    # Register the lexer
    Registry.register_lexer_with_name("crazy_lexer", {CrazyLexer, [opt1: 1, opt2: "2"]})
    # Fetch the lexer
    assert {:ok, {CrazyLexer, [opt1: 1, opt2: "2"]}} ==
             Registry.fetch_lexer_by_name("crazy_lexer")

    assert {CrazyLexer, [opt1: 1, opt2: "2"]} == Registry.fetch_lexer_by_name!("crazy_lexer")
  end

  test "fail to get a  lexer that hasn't been registered" do
    assert :error == Registry.fetch_lexer_by_name("lexer_that_doesnt_exist")

    assert_raise KeyError, fn ->
      Registry.fetch_lexer_by_name!("lexer_that_doesnt_exist")
    end
  end
end
