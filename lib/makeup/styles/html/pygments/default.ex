
defmodule Makeup.Styles.HTML.DefaultStyle do
  @moduledoc """
  The default highlighting style.
  
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
    Tok.error => "border:#FF0000",
    Tok.keyword => "bold #008000",
    Tok.keyword_pseudo => "nobold",
    Tok.keyword_type => "nobold #B00040",
    Tok.name_attribute => "#7D9029",
    Tok.name_builtin => "#008000",
    Tok.name_class => "bold #0000FF",
    Tok.name_constant => "#880000",
    Tok.name_decorator => "#AA22FF",
    Tok.name_entity => "bold #999999",
    Tok.name_exception => "bold #D2413A",
    Tok.name_function => "#0000FF",
    Tok.name_label => "#A0A000",
    Tok.name_namespace => "bold #0000FF",
    Tok.name_tag => "bold #008000",
    Tok.name_variable => "#19177C",
    Tok.string => "#BA2121",
    Tok.string_doc => "italic",
    Tok.string_escape => "bold #BB6622",
    Tok.string_interpol => "bold #BB6688",
    Tok.string_other => "#008000",
    Tok.string_regex => "#BB6688",
    Tok.string_symbol => "#19177C",
    Tok.number => "#666666",
    Tok.operator => "#666666",
    Tok.operator_word => "bold #AA22FF",
    Tok.comment => "italic #408080",
    Tok.comment_preproc => "noitalic #BC7A00",
    Tok.generic_deleted => "#A00000",
    Tok.generic_emph => "italic",
    Tok.generic_error => "#FF0000",
    Tok.generic_heading => "bold #000080",
    Tok.generic_inserted => "#00A000",
    Tok.generic_output => "#888",
    Tok.generic_prompt => "bold #000080",
    Tok.generic_strong => "bold",
    Tok.generic_subheading => "bold #800080",
    Tok.generic_traceback => "#04D"
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  def style() do
    Style.make_style(
      short_name: "default",
      long_name: "Default Style",
      background_color: "#f8f8f8",
      highlight_color: "#ffffcc",
      styles: @styles)
  end
end