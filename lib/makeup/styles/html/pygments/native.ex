
defmodule Makeup.Styles.HTML.NativeStyle do
  @moduledoc """
  pygments version of my "native" vim theme.
  
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
    Tok.error => "bg:#e3d2d2 #a61717",
    Tok.keyword => "bold #6ab825",
    Tok.keyword_pseudo => "nobold",
    Tok.name_attribute => "#bbbbbb",
    Tok.name_builtin => "#24909d",
    Tok.name_class => "underline #447fcf",
    Tok.name_constant => "#40ffff",
    Tok.name_decorator => "#ffa500",
    Tok.name_exception => "#bbbbbb",
    Tok.name_function => "#447fcf",
    Tok.name_namespace => "underline #447fcf",
    Tok.name_tag => "bold #6ab825",
    Tok.name_variable => "#40ffff",
    Tok.string => "#ed9d13",
    Tok.string_other => "#ffa500",
    Tok.number => "#3677a9",
    Tok.operator_word => "bold #6ab825",
    Tok.comment => "italic #999999",
    Tok.comment_preproc => "noitalic bold #cd2828",
    Tok.comment_special => "noitalic bold #e50808 bg:#520000",
    Tok.generic_deleted => "#d22323",
    Tok.generic_emph => "italic",
    Tok.generic_error => "#d22323",
    Tok.generic_heading => "bold #ffffff",
    Tok.generic_inserted => "#589819",
    Tok.generic_output => "#cccccc",
    Tok.generic_prompt => "#aaaaaa",
    Tok.generic_strong => "bold",
    Tok.generic_subheading => "underline #ffffff",
    Tok.generic_traceback => "#d22323"
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  def style() do
    Style.make_style(
      short_name: "native",
      long_name: "Native Style",
      background_color: "#202020",
      highlight_color: "#404040",
      styles: @styles)
  end
end