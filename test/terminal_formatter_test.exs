defmodule MakeupTest.Lexer.TerminalFormatterTest do
  use ExUnit.Case, async: true
  import ExUnitProperties
  alias Makeup.Formatters.Terminal.TerminalFormatter

  test "encode ASCII character" do
    check all c <- StreamData.integer(1..16666) do
      char = << c :: utf8 >>
      formatted =
        TerminalFormatter.format_as_binary([{:string, %{}, c}])
        |> String.codepoints()

      assert char in formatted
    end
  end

  test "raise exception when token is not an iolist" do
    msg = "Found `%{}` inside what should be an iolist"

    assert_raise RuntimeError, msg, fn ->
      assert TerminalFormatter.format_as_binary([{:string, %{}, %{}}])
    end
  end
end
