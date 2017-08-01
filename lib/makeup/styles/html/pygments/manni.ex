
defmodule Makeup.Styles.HTML.ManniStyle do
  @moduledoc """
  A colorful style, inspired by the terminal highlighting style.
  
  This is a port of the style used in the `php port`_ of pygments
  by Manni. The style is called 'default' there.
  
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
    Tok.error => "bg:#FFAAAA #AA0000",
    Tok.keyword => "bold #006699",
    Tok.keyword_pseudo => "nobold",
    Tok.keyword_type => "#007788",
    Tok.name_attribute => "#330099",
    Tok.name_builtin => "#336666",
    Tok.name_class => "bold #00AA88",
    Tok.name_constant => "#336600",
    Tok.name_decorator => "#9999FF",
    Tok.name_entity => "bold #999999",
    Tok.name_exception => "bold #CC0000",
    Tok.name_function => "#CC00FF",
    Tok.name_label => "#9999FF",
    Tok.name_namespace => "bold #00CCFF",
    Tok.name_tag => "bold #330099",
    Tok.name_variable => "#003333",
    Tok.string => "#CC3300",
    Tok.string_doc => "italic",
    Tok.string_escape => "bold #CC3300",
    Tok.string_interpol => "#AA0000",
    Tok.string_other => "#CC3300",
    Tok.string_regex => "#33AAAA",
    Tok.string_symbol => "#FFCC33",
    Tok.number => "#FF6600",
    Tok.operator => "#555555",
    Tok.operator_word => "bold #000000",
    Tok.comment => "italic #0099FF",
    Tok.comment_preproc => "noitalic #009999",
    Tok.comment_special => "bold",
    Tok.generic_deleted => "border:#CC0000 bg:#FFCCCC",
    Tok.generic_emph => "italic",
    Tok.generic_error => "#FF0000",
    Tok.generic_heading => "bold #003300",
    Tok.generic_inserted => "border:#00CC00 bg:#CCFFCC",
    Tok.generic_output => "#AAAAAA",
    Tok.generic_prompt => "bold #000099",
    Tok.generic_strong => "bold",
    Tok.generic_subheading => "bold #003300",
    Tok.generic_traceback => "#99CC66"
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  def style() do
    Style.make_style(
      short_name: "manni",
      long_name: "Manni Style",
      background_color: "#f0f3f3",
      highlight_color: "#ffffcc",
      styles: @styles)
  end
end