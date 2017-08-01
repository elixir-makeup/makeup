
defmodule Makeup.Styles.HTML.IgorStyle do
  @moduledoc """
  Igor Pro default style.
  
  &copy; Copyright 2006-2017 by the Pygments team, see AUTHORS.
  License: BSD, see [here](https://opensource.org/licenses/BSD-3-Clause) for details.

  <table>
    <thead><tr><th>Warning</th></tr></thead>
    <tbody><tr><td>
      This file was automatically generated from the Pygments source.
      Any edits to this file may be lost if the file is regenerated.
    </td></tr></tbody>
  </table>
  """

  require Makeup.Token.TokenTypes
  alias Makeup.Token.TokenTypes, as: Tok

  @styles %{
    Tok.keyword => "#0000FF",
    Tok.name_class => "#007575",
    Tok.name_decorator => "#CC00A3",
    Tok.name_function => "#C34E00",
    Tok.string => "#009C00",
    Tok.comment => "italic #FF0000",
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  def style() do
    Style.make_style(
      short_name: "igor",
      long_name: "Igor Style",
      background_color: "#ffffff",
      highlight_color: "#ffffcc",
      styles: @styles)
  end
end