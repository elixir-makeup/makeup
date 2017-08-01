
defmodule Makeup.Styles.HTML.VimStyle do
  @moduledoc """
  A highlighting style for Pygments, inspired by vim.
  
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
    Tok.keyword => "#cdcd00",
    Tok.keyword_declaration => "#00cd00",
    Tok.keyword_namespace => "#cd00cd",
    Tok.keyword_type => "#00cd00",
    Tok.name_builtin => "#cd00cd",
    Tok.name_class => "#00cdcd",
    Tok.name_exception => "bold #666699",
    Tok.name_variable => "#00cdcd",
    Tok.string => "#cd0000",
    Tok.number => "#cd00cd",
    Tok.operator => "#3399cc",
    Tok.operator_word => "#cdcd00",
    Tok.comment => "#000080",
    Tok.comment_special => "bold #cd0000",
    Tok.generic_deleted => "#cd0000",
    Tok.generic_emph => "italic",
    Tok.generic_error => "#FF0000",
    Tok.generic_heading => "bold #000080",
    Tok.generic_inserted => "#00cd00",
    Tok.generic_output => "#888",
    Tok.generic_prompt => "bold #000080",
    Tok.generic_strong => "bold",
    Tok.generic_subheading => "bold #800080",
    Tok.generic_traceback => "#04D"
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  def style() do
    Style.make_style(
      short_name: "vim",
      long_name: "Vim Style",
      background_color: "#000000",
      highlight_color: "#222222",
      styles: @styles)
  end
end