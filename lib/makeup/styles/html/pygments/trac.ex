
defmodule Makeup.Styles.HTML.TracStyle do
  @moduledoc """
  Port of the default trac highlighter design.
  
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
    Tok.keyword => "bold",
    Tok.keyword_type => "#445588",
    Tok.name_attribute => "#008080",
    Tok.name_builtin => "#999999",
    Tok.name_class => "bold #445588",
    Tok.name_constant => "#008080",
    Tok.name_entity => "#800080",
    Tok.name_exception => "bold #990000",
    Tok.name_function => "bold #990000",
    Tok.name_namespace => "#555555",
    Tok.name_tag => "#000080",
    Tok.name_variable => "#008080",
    Tok.string => "#bb8844",
    Tok.string_regex => "#808000",
    Tok.number => "#009999",
    Tok.operator => "bold",
    Tok.comment => "italic #999988",
    Tok.comment_preproc => "bold noitalic #999999",
    Tok.comment_special => "bold #999999",
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
      short_name: "trac",
      long_name: "Trac Style",
      background_color: "#ffffff",
      highlight_color: "#ffffcc",
      styles: @styles)
  end
end