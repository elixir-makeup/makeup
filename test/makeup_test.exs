defmodule MakeupTest do
  use ExUnit.Case
  doctest Makeup

  defmodule FakeLexer do
    @behaviour Makeup.Lexer

    @impl true
    def root_element(_), do: raise("Not implemented")

    @impl true
    def root(_), do: raise("Not implemented")

    @impl true
    def postprocess(_, _), do: raise("Not implemented")

    @impl true
    def match_groups(_, _), do: raise("Not implemented")

    @impl true
    def lex("CompiledWithDocs.example", _lexer_options) do
      [
        {:name_class, %{language: :elixir}, ["C", "ompiledWithDocs"]},
        {:operator, %{language: :elixir}, "."},
        {:name, %{language: :elixir}, "example"}
      ]
    end
  end

  describe "stylesheet" do
    test "returns stylesheet in given style" do
      assert Makeup.stylesheet() =~ ".highlight .hll"
      assert Makeup.stylesheet(:vim_style) =~ ".highlight .hll"
      assert Makeup.stylesheet(:vim_style, "makeup") =~ ".makeup .hll"

      assert Makeup.stylesheet(Makeup.Styles.HTML.StyleMap.vim_style(), "makeup") =~
               ".makeup .hll"
    end
  end
end
