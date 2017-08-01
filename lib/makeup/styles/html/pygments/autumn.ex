
defmodule Makeup.Styles.HTML.AutumnStyle do
  @moduledoc """
  A colorful style, inspired by the terminal highlighting style.
  
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
    Tok.keyword => "#0000aa",
    Tok.keyword_type => "#00aaaa",
    Tok.name_attribute => "#1e90ff",
    Tok.name_builtin => "#00aaaa",
    Tok.name_class => "underline #00aa00",
    Tok.name_constant => "#aa0000",
    Tok.name_decorator => "#888888",
    Tok.name_entity => "bold #800",
    Tok.name_function => "#00aa00",
    Tok.name_namespace => "underline #00aaaa",
    Tok.name_tag => "bold #1e90ff",
    Tok.name_variable => "#aa0000",
    Tok.string => "#aa5500",
    Tok.string_regex => "#009999",
    Tok.string_symbol => "#0000aa",
    Tok.number => "#009999",
    Tok.operator_word => "#0000aa",
    Tok.comment => "italic #aaaaaa",
    Tok.comment_preproc => "noitalic #4c8317",
    Tok.comment_special => "italic #0000aa",
    Tok.generic_deleted => "#aa0000",
    Tok.generic_emph => "italic",
    Tok.generic_error => "#aa0000",
    Tok.generic_heading => "bold #000080",
    Tok.generic_inserted => "#00aa00",
    Tok.generic_output => "#888888",
    Tok.generic_prompt => "#555555",
    Tok.generic_strong => "bold",
    Tok.generic_subheading => "bold #800080",
    Tok.generic_traceback => "#aa0000"
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  def style() do
    Style.make_style(
      short_name: "autumn",
      long_name: "Autumn Style",
      background_color: "#ffffff",
      highlight_color: "#ffffcc",
      styles: @styles)
  end
end