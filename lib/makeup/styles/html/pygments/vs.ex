
defmodule Makeup.Styles.HTML.VisualStudioStyle do
  @moduledoc """
  Simple style with MS Visual Studio colors.
  
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
    Tok.keyword => "#0000ff",
    Tok.keyword_type => "#2b91af",
    Tok.name_class => "#2b91af",
    Tok.string => "#a31515",
    Tok.operator_word => "#0000ff",
    Tok.comment => "#008000",
    Tok.comment_preproc => "#0000ff",
    Tok.generic_emph => "italic",
    Tok.generic_heading => "bold",
    Tok.generic_prompt => "bold",
    Tok.generic_strong => "bold",
    Tok.generic_subheading => "bold",
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  def style() do
    Style.make_style(
      short_name: "vs",
      long_name: "VisualStudio Style",
      background_color: "#ffffff",
      highlight_color: "#ffffcc",
      styles: @styles)
  end
end