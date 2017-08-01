
defmodule Makeup.Styles.HTML.MurphyStyle do
  @moduledoc """
  Murphy's style from CodeRay.
  
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
    Tok.error => "#F00 bg:#FAA",
    Tok.keyword => "bold #289",
    Tok.keyword_pseudo => "#08f",
    Tok.keyword_type => "#66f",
    Tok.name_attribute => "#007",
    Tok.name_builtin => "#072",
    Tok.name_class => "bold #e9e",
    Tok.name_constant => "bold #5ed",
    Tok.name_decorator => "bold #555",
    Tok.name_entity => "#800",
    Tok.name_exception => "bold #F00",
    Tok.name_function => "bold #5ed",
    Tok.name_label => "bold #970",
    Tok.name_namespace => "bold #0e84b5",
    Tok.name_tag => "#070",
    Tok.name_variable => "#036",
    Tok.name_variable_class => "#ccf",
    Tok.name_variable_global => "#f84",
    Tok.name_variable_instance => "#aaf",
    Tok.string => "bg:#e0e0ff",
    Tok.string_char => "#88F bg:",
    Tok.string_doc => "#D42 bg:",
    Tok.string_escape => "bold #666",
    Tok.string_interpol => "bg:#eee",
    Tok.string_other => "#f88",
    Tok.string_regex => "bg:#e0e0ff #000",
    Tok.string_symbol => "#fc8 bg:",
    Tok.number => "bold #60E",
    Tok.number_float => "bold #60E",
    Tok.number_hex => "bold #058",
    Tok.number_integer => "bold #66f",
    Tok.number_oct => "bold #40E",
    Tok.operator => "#333",
    Tok.operator_word => "bold #000",
    Tok.comment => "#666 italic",
    Tok.comment_preproc => "#579 noitalic",
    Tok.comment_special => "#c00 bold",
    Tok.generic_deleted => "#A00000",
    Tok.generic_emph => "italic",
    Tok.generic_error => "#FF0000",
    Tok.generic_heading => "bold #000080",
    Tok.generic_inserted => "#00A000",
    Tok.generic_output => "#888",
    Tok.generic_prompt => "bold #c65d09",
    Tok.generic_strong => "bold",
    Tok.generic_subheading => "bold #800080",
    Tok.generic_traceback => "#04D"
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  def style() do
    Style.make_style(
      short_name: "murphy",
      long_name: "Murphy Style",
      background_color: "#ffffff",
      highlight_color: "#ffffcc",
      styles: @styles)
  end
end