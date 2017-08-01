
defmodule Makeup.Styles.HTML.ColorfulStyle do
  @moduledoc """
  A colorful style, inspired by CodeRay.
  
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
    Tok.keyword => "bold #080",
    Tok.keyword_pseudo => "#038",
    Tok.keyword_type => "#339",
    Tok.name_attribute => "#00C",
    Tok.name_builtin => "#007020",
    Tok.name_class => "bold #B06",
    Tok.name_constant => "bold #036",
    Tok.name_decorator => "bold #555",
    Tok.name_entity => "bold #800",
    Tok.name_exception => "bold #F00",
    Tok.name_function => "bold #06B",
    Tok.name_label => "bold #970",
    Tok.name_namespace => "bold #0e84b5",
    Tok.name_tag => "#070",
    Tok.name_variable => "#963",
    Tok.name_variable_class => "#369",
    Tok.name_variable_global => "bold #d70",
    Tok.name_variable_instance => "#33B",
    Tok.string => "bg:#fff0f0",
    Tok.string_char => "#04D bg:",
    Tok.string_doc => "#D42 bg:",
    Tok.string_escape => "bold #666",
    Tok.string_interpol => "bg:#eee",
    Tok.string_other => "#D20",
    Tok.string_regex => "bg:#fff0ff #000",
    Tok.string_symbol => "#A60 bg:",
    Tok.number => "bold #60E",
    Tok.number_float => "bold #60E",
    Tok.number_hex => "bold #058",
    Tok.number_integer => "bold #00D",
    Tok.number_oct => "bold #40E",
    Tok.operator => "#333",
    Tok.operator_word => "bold #000",
    Tok.comment => "#888",
    Tok.comment_preproc => "#579",
    Tok.comment_special => "bold #cc0000",
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
      short_name: "colorful",
      long_name: "Colorful Style",
      background_color: "#ffffff",
      highlight_color: "#ffffcc",
      styles: @styles)
  end
end