defmodule Makeup.RegistryTest do
  use ExUnit.Case
  alias Makeup.Registry
  doctest Registry

  setup do
    Registry.clean_name_registry()
    Registry.clean_extension_registry()

    :ok
  end

  describe "register lexer by name" do
    test "register a lexer by name and fetch it afterwards" do
      # Register the lexer
      Registry.register_lexer_with_name("crazy_lexer", {CrazyLexer, [opt1: 1, opt2: "2"]})
      # Fetch the lexer
      assert {:ok, {CrazyLexer, [opt1: 1, opt2: "2"]}} ==
               Registry.fetch_lexer_by_name("crazy_lexer")

      assert {CrazyLexer, [opt1: 1, opt2: "2"]} == Registry.fetch_lexer_by_name!("crazy_lexer")
    end

    test "fail to get a lexer that hasn't been registered by name" do
      assert nil == Registry.get_lexer_by_extension("ext_that_doesnt_exist")

      assert :error == Registry.fetch_lexer_by_name("lexer_that_doesnt_exist")

      assert_raise KeyError, fn ->
        Registry.fetch_lexer_by_name!("lexer_that_doesnt_exist")
      end
    end
  end

  describe "register lexer by file extension" do
    test "register a lexer by extension and fetch it afterwards" do
      # Register the lexer
      Registry.register_lexer_with_extension("cz", {CrazierLexer, [opt1: 2, opt2: "3"]})
      # Fetch the lexer
      assert {:ok, {CrazierLexer, [opt1: 2, opt2: "3"]}} ==
               Registry.fetch_lexer_by_extension("cz")

      assert {CrazierLexer, [opt1: 2, opt2: "3"]} == Registry.fetch_lexer_by_extension!("cz")
      assert {CrazierLexer, [opt1: 2, opt2: "3"]} == Registry.get_lexer_by_extension("cz")
    end

    test "fail to get a lexer that hasn't been registered by extension" do
      assert nil == Registry.get_lexer_by_extension("ext_that_doesnt_exist")

      assert :error == Registry.fetch_lexer_by_extension("ext_that_doesnt_exist")

      assert_raise KeyError, fn ->
        Registry.fetch_lexer_by_extension!("ext_that_doesnt_exist")
      end
    end
  end

  describe "register lexer using the high level API" do
    setup "register and fetch a lexer" do
      Registry.register_lexer(MadLexer,
        options: [opt1: "a", opt2: "b"],
        names: ["mad_lexer1", "mad_lexer2"],
        extensions: ["ml1", "ml2"]
      )

      # Fetching by name
      assert assert {:ok, {CrazierLexer, [opt1: "a", opt2: "b"]}} ==
                      Registry.fetch_lexer_by_extension("mad_lexer1")

      assert assert {:ok, {CrazierLexer, [opt1: "a", opt2: "b"]}} ==
                      Registry.fetch_lexer_by_extension("mad_lexer2")

      assert {CrazierLexer, [opt1: "a", opt2: "b"]} = Registry.fetch_lexer_by_name!("mad_lexer1")
      assert {CrazierLexer, [opt1: "a", opt2: "b"]} = Registry.fetch_lexer_by_name!("mad_lexer2")

      assert {CrazierLexer, [opt1: "a", opt2: "b"]} = Registry.get_lexer_by_name("mad_lexer1")
      assert {CrazierLexer, [opt1: "a", opt2: "b"]} = Registry.get_lexer_by_name("mad_lexer2")
      # Fetching by extension
      assert assert {:ok, {CrazierLexer, [opt1: "a", opt2: "b"]}} ==
                      Registry.fetch_lexer_by_extension("ml1")

      assert assert {:ok, {CrazierLexer, [opt1: "a", opt2: "b"]}} ==
                      Registry.fetch_lexer_by_extension("ml2")

      assert {CrazierLexer, [opt1: "a", opt2: "b"]} = Registry.fetch_lexer_by_extension!("ml1")
      assert {CrazierLexer, [opt1: "a", opt2: "b"]} = Registry.fetch_lexer_by_extension!("ml2")

      assert {CrazierLexer, [opt1: "a", opt2: "b"]} = Registry.get_lexer_by_extension!("ml1")
      assert {CrazierLexer, [opt1: "a", opt2: "b"]} = Registry.get_lexer_by_extension!("ml2")
    end
  end
end
