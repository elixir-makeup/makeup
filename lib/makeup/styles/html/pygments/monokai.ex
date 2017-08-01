
defmodule Makeup.Styles.HTML.MonokaiStyle do
  @moduledoc """
  Mimic the Monokai color scheme. Based on tango.py.
  
  http://www.monokai.nl/blog/2006/07/15/textmate-color-theme/
  
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
    Tok.text => "#f8f8f2",
    Tok.error => "#960050 bg:#1e0010",
    Tok.keyword => "#66d9ef",
    Tok.keyword_namespace => "#f92672",
    Tok.name => "#f8f8f2",
    Tok.name_attribute => "#a6e22e",
    Tok.name_class => "#a6e22e",
    Tok.name_constant => "#66d9ef",
    Tok.name_decorator => "#a6e22e",
    Tok.name_exception => "#a6e22e",
    Tok.name_function => "#a6e22e",
    Tok.name_other => "#a6e22e",
    Tok.name_tag => "#f92672",
    Tok.literal => "#ae81ff",
    Tok.string => "#e6db74",
    Tok.string_escape => "#ae81ff",
    Tok.number => "#ae81ff",
    Tok.operator => "#f92672",
    Tok.punctuation => "#f8f8f2",
    Tok.comment => "#75715e",
    Tok.generic_deleted => "#f92672",
    Tok.generic_emph => "italic",
    Tok.generic_inserted => "#a6e22e",
    Tok.generic_strong => "bold",
    Tok.generic_subheading => "#75715e",
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  def style() do
    Style.make_style(
      short_name: "monokai",
      long_name: "Monokai Style",
      background_color: "#272822",
      highlight_color: "#49483e",
      styles: @styles)
  end
end