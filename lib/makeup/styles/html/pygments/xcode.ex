
defmodule Makeup.Styles.HTML.XcodeStyle do
  @moduledoc """
  Style similar to the `Xcode` default theme.
  
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
    Tok.error => "#000000",
    Tok.keyword => "#A90D91",
    Tok.name => "#000000",
    Tok.name_attribute => "#836C28",
    Tok.name_builtin => "#A90D91",
    Tok.name_builtin_pseudo => "#5B269A",
    Tok.name_class => "#3F6E75",
    Tok.name_decorator => "#000000",
    Tok.name_function => "#000000",
    Tok.name_label => "#000000",
    Tok.name_tag => "#000000",
    Tok.name_variable => "#000000",
    Tok.literal => "#1C01CE",
    Tok.string => "#C41A16",
    Tok.string_char => "#2300CE",
    Tok.number => "#1C01CE",
    Tok.operator => "#000000",
    Tok.comment => "#177500",
    Tok.comment_preproc => "#633820",
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  def style() do
    Style.make_style(
      short_name: "xcode",
      long_name: "Xcode Style",
      background_color: "#ffffff",
      highlight_color: "#ffffcc",
      styles: @styles)
  end
end