defmodule Makeup.Formatters.HTML.HTMLFormatter do

  @group_highlight_js "lib/makeup/formatters/html/scripts/group_highlighter_javascript.js" |> File.read!

  defp render_token(escaped_value, css_class, meta) do
    group_id = meta[:group_id]
    selectable = Map.get(meta, :selectable, [])

    classes = [
      css_class || [],
      if selectable == false do " unselectable" else [] end
    ]

    [
      ~S(<span),
      ~S( class="),
      classes,
      ~S("),
      if group_id do [~S( data-group-id="), group_id, ~S(")] else [] end,
      ">",
      escaped_value,
      ~S(</span>)
    ]
  end

  def format_token({tag, meta, value}) do
    escaped_value = escape(value)
    css_class = Makeup.Token.Utils.css_class_for_token_type(tag)
    render_token(escaped_value, css_class, meta)
  end

  defp escape_for(?&), do: "&amp;"

  defp escape_for(?<), do: "&lt;"

  defp escape_for(?>), do: "&gt;"

  defp escape_for(?"), do: "&quot;"

  defp escape_for(?'), do: "&#39;"

  defp escape_for(c) when is_integer(c) and c <= 127, do: c

  defp escape_for(c) when is_integer(c) and c > 128, do: << c :: utf8 >>

  defp escape_for(string) when is_binary(string) do
    string
    |> to_charlist()
    |> Enum.map(&escape_for/1)
  end

  defp escape(iodata) when is_list(iodata) do
    iodata
    |> :lists.flatten()
    |> Enum.map(&escape_for/1)
  end

  defp escape(other) when is_binary(other) do
    escape_for(other)
  end

  defp escape(c) when is_integer(c) do
    #
    [escape_for(c)]
  end

  defp escape(other) do
    raise "Found `#{inspect(other)}` inside what should be an iolist"
  end

  def format_inner_as_iolist(tokens) do
    Enum.map(tokens, &format_token/1)
  end

  def format_inner_as_binary(tokens) do
    tokens
    |> format_inner_as_iolist
    |> IO.iodata_to_binary
  end

  def format_as_iolist(tokens, css_class \\ "highlight") do
    inner = format_inner_as_iolist(tokens)

    [
      ~S(<pre class="),
      css_class,
      ~S("><code>),
      inner,
      ~S(</code></pre>)
    ]
  end

  def format_as_binary(tokens, css_class \\ "highlight") do
    tokens
    |> format_as_iolist(css_class)
    |> IO.iodata_to_binary
  end

  def stylesheet(style, css_class \\ "highlight") do
    Makeup.Styles.HTML.Style.stylesheet(style, css_class)
  end

  def group_highlighter_javascript() do
    @group_highlight_js
  end
end
