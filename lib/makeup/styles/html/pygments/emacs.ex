
defmodule Makeup.Styles.HTML.EmacsStyle do
  @moduledoc """
  A highlighting style for Pygments, inspired by Emacs.
  
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
    Tok.keyword => "bold #AA22FF",
    Tok.keyword_pseudo => "nobold",
    Tok.keyword_type => "bold #00BB00",
    Tok.name_attribute => "#BB4444",
    Tok.name_builtin => "#AA22FF",
    Tok.name_class => "#0000FF",
    Tok.name_constant => "#880000",
    Tok.name_decorator => "#AA22FF",
    Tok.name_entity => "bold #999999",
    Tok.name_exception => "bold #D2413A",
    Tok.name_function => "#00A000",
    Tok.name_label => "#A0A000",
    Tok.name_namespace => "bold #0000FF",
    Tok.name_tag => "bold #008000",
    Tok.name_variable => "#B8860B",
    Tok.string => "#BB4444",
    Tok.string_doc => "italic",
    Tok.string_escape => "bold #BB6622",
    Tok.string_interpol => "bold #BB6688",
    Tok.string_other => "#008000",
    Tok.string_regex => "#BB6688",
    Tok.string_symbol => "#B8860B",
    Tok.number => "#666666",
    Tok.operator => "#666666",
    Tok.operator_word => "bold #AA22FF",
    Tok.comment => "italic #008800",
    Tok.comment_preproc => "noitalic",
    Tok.comment_special => "noitalic bold",
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
      short_name: "emacs",
      long_name: "Emacs Style",
      background_color: "#f8f8f8",
      highlight_color: "#ffffcc",
      styles: @styles)
  end
end