
defmodule Makeup.Styles.HTML.BlackWhiteStyle do
  @moduledoc """
  Simple black/white only style.
  
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
    Tok.keyword => "bold",
    Tok.keyword_pseudo => "nobold",
    Tok.keyword_type => "nobold",
    Tok.name_class => "bold",
    Tok.name_entity => "bold",
    Tok.name_exception => "bold",
    Tok.name_namespace => "bold",
    Tok.name_tag => "bold",
    Tok.string => "italic",
    Tok.string_escape => "bold",
    Tok.string_interpol => "bold",
    Tok.operator_word => "bold",
    Tok.comment => "italic",
    Tok.comment_preproc => "noitalic",
    Tok.generic_emph => "italic",
    Tok.generic_heading => "bold",
    Tok.generic_prompt => "bold",
    Tok.generic_strong => "bold",
    Tok.generic_subheading => "bold",
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  def style() do
    Style.make_style(
      short_name: "bw",
      long_name: "BlackWhite Style",
      background_color: "#ffffff",
      highlight_color: "#ffffcc",
      styles: @styles)
  end
end