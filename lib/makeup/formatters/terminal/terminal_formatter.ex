defmodule Makeup.Formatters.Terminal.TerminalFormatter do
  @moduledoc """
  Turns a list of tokens into the appropiate sequence of ANSI escape codes,
  suitable to be printed in a terminal.
  """

  alias Makeup.Styles.HTML.StyleMap
  alias IO.ANSI

  # For some reason the IO.ANSI module only accepts 8 bit ANSI colors. So this
  # is a mostly copy pasted version of the ANSI.color/3 that deals with 24 bit
  # colors.
  defp color([r, g, b]), do: color(r, g, b)

  defp color(r, g, b) when r in 0..255 and g in 0..255 and b in 0..255 do
    "\e[38;2;#{r};#{g};#{b}m"
  end

  defp color_background([r, g, b]), do: color_background(r, g, b)

  defp color_background(r, g, b) when r in 0..255 and g in 0..255 and b in 0..255 do
    "\e[48;2;#{r};#{g};#{b}m"
  end

  # Parses the hex color string into a list of integers.
  defp hex_values("#" <> colors) do
    colors
    |> String.codepoints()
    |> Enum.chunk_every(2)
    |> Enum.map(fn hex_color_list ->
      hex_color_list
      |> Enum.join()
      |> String.to_integer(16)
    end)
  end

  # Transforms `Makeup.Styles.HTML.Style` attributes into ANSI codes. Because
  # escape codes are always inline, each attribute is translated into a tuple
  # of two ANSI codes; one for setting it and one for resetting the default
  # value.
  defp get_ansi(style_attr, defaults)

  defp get_ansi({_, nil}, _defaults), do: []

  defp get_ansi({:background_color, c}, defaults),
    do: [
      {
        c |> hex_values() |> color_background(),
        Map.get(defaults, :background_color)
      }
    ]

  defp get_ansi({:color, c}, _defaults),
    do: [{c |> hex_values() |> color(), ANSI.default_color()}]

  defp get_ansi({:font_style, sty}, _defaults) when sty in ["italic", "oblique"],
    do: [{ANSI.italic(), ANSI.not_italic()}]

  defp get_ansi({:font_weight, "bold"}, _defaults), do: [{ANSI.bright(), ANSI.normal()}]

  defp get_ansi({:text_decoration, "underline"}, _defaults),
    do: [{ANSI.underline(), ANSI.no_underline()}]

  defp get_ansi({_, _}, _defaults), do: []

  defp escape(v) when is_list(v), do: Enum.map(v, &escape/1)
  defp escape(v) when is_integer(v), do: <<v::utf8>>
  defp escape(v) when is_bitstring(v), do: v

  defp escape(v) do
    raise "Found `#{inspect(v)}` inside what should be an iolist"
  end

  @doc """
  Format a single token into an IO list of ANSI escape codes.
  """
  def format_token({tag, _meta, val}, styles, defaults) do
    {set_ansi, reset_ansi} =
      styles
      |> Map.get(tag)
      |> Map.to_list()
      |> Enum.flat_map(&get_ansi(&1, defaults))
      |> Enum.unzip()

    [
      set_ansi,
      escape(val),
      reset_ansi
    ]
  end

  @doc """
  Turns a list of tokens into an IO list of ANSI escape codes.
  """
  def format_as_iolist(tokens, opts \\ []) do
    style_name = Keyword.get(opts, :style, :default_style)
    style = apply(StyleMap, style_name, [])
    default_bg = style.background_color |> hex_values() |> color_background()

    style_defaults = %{
      background_color: default_bg
    }

    [
      ANSI.reset(),
      default_bg,
      Enum.map(tokens, &format_token(&1, style.styles, style_defaults)),
      ANSI.reset()
    ]
  end

  @doc """
  Turns a list of tokens into a string with the appropriate ANSI escape codes.
  This string is suitable to be printed in a terminal.
  """
  def format_as_binary(tokens, opts \\ []) do
    tokens
    |> format_as_iolist(opts)
    |> IO.iodata_to_binary()
  end
end
