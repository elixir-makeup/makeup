defmodule MakeupTest.Lexer.HTMLFormatterTest do
  use ExUnit.Case, async: true
  import ExUnitProperties
  alias Makeup.Formatters.HTML.HTMLFormatter

  test "edge case - character with value = 128" do
    # Handles an edge case in the HTML formatter (already fixed),
    # in which the case c == 128 wasn't handled.
    # The previous version would raise an error.
    
    # Encode the right hand side as a concatenation of binaries
    # to make it more obvious:
    assert HTMLFormatter.format_as_binary([{:string, %{}, [128]}]) ==
      ~S[<pre class="highlight"><code>] <>
      ~S[<span class="s">] <>
      << 128 :: utf8 >> <>
      ~S[</span>] <>
      ~S[</code></pre>]
  end

  test "encode ASCII character (c <= 127)" do
    # Handles an edge case in the HTML formatter (already fixed),
    # in which the case c == 128 wasn't handled.
    # The previous version would raise an error.
    
    # Encode the right hand side as a concatenation of binaries
    # to make it more obvious:
    check all c <- StreamData.integer(1..127),
              not(c in [?&, ?<, ?>, ?", ?']) do
      assert HTMLFormatter.format_as_binary([{:string, %{}, [c]}]) ==
        ~S[<pre class="highlight"><code>] <>
        ~S[<span class="s">] <>
        << c >> <>
        ~S[</span>] <>
        ~S[</code></pre>]
    end
  end

  test "encode ASCII character (c >= 128)" do
    # Some of these characters won't be valid unicode but that doesn't matter
    
    # Encode the right hand side as a concatenation of binaries
    # to make it more obvious:
    check all c <- StreamData.integer(128..16666) do
      assert HTMLFormatter.format_as_binary([{:string, %{}, [c]}]) ==
        ~S[<pre class="highlight"><code>] <>
        ~S[<span class="s">] <>
        << c :: utf8 >> <>
        ~S[</span>] <>
        ~S[</code></pre>]
    end
  end

  test "special characters are correctly encoded" do
    for {c, encoded} <- [
      {?&, "&amp;"},
      {?<, "&lt;"},
      {?>, "&gt;"},
      {?", "&quot;"},
      {?', "&#39;"}
    ] do
      assert HTMLFormatter.format_as_binary([{:string, %{}, [c]}]) ==
        ~S[<pre class="highlight"><code>] <>
        ~S[<span class="s">] <>
        encoded <>
        ~S[</span>] <>
        ~S[</code></pre>]
    end
  end
end