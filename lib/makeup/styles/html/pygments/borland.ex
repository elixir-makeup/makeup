
defmodule Makeup.Styles.HTML.BorlandStyle do
  @moduledoc """
  Style similar to the style used in the Borland IDEs.
  
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
    Tok.error => "bg:#e3d2d2 #a61717",
    Tok.keyword => "bold #000080",
    Tok.name_attribute => "#FF0000",
    Tok.name_tag => "bold #000080",
    Tok.string => "#0000FF",
    Tok.string_char => "#800080",
    Tok.number => "#0000FF",
    Tok.operator_word => "bold",
    Tok.comment => "italic #008800",
    Tok.comment_preproc => "noitalic #008080",
    Tok.comment_special => "noitalic bold",
    Tok.generic_deleted => "bg:#ffdddd #000000",
    Tok.generic_emph => "italic",
    Tok.generic_error => "#aa0000",
    Tok.generic_heading => "#999999",
    Tok.generic_inserted => "bg:#ddffdd #000000",
    Tok.generic_output => "#888888",
    Tok.generic_prompt => "#555555",
    Tok.generic_strong => "bold",
    Tok.generic_subheading => "#aaaaaa",
    Tok.generic_traceback => "#aa0000"
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  def style() do
    Style.make_style(
      short_name: "borland",
      long_name: "Borland Style",
      background_color: "#ffffff",
      highlight_color: "#ffffcc",
      styles: @styles)
  end
end