
defmodule Makeup.Styles.HTML.AbapStyle do
  @moduledoc """
  ABAP workbench like style.
  
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
    Tok.error => "#F00",
    Tok.keyword => "#00f",
    Tok.name => "#000",
    Tok.string => "#5a2",
    Tok.number => "#3af",
    Tok.operator_word => "#00f",
    Tok.comment => "italic #888",
    Tok.comment_special => "#888",
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  def style() do
    Style.make_style(
      short_name: "abap",
      long_name: "Abap Style",
      background_color: "#ffffff",
      highlight_color: "#ffffcc",
      styles: @styles)
  end
end