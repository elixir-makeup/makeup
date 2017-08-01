
defmodule Makeup.Styles.HTML.RrtStyle do
  @moduledoc """
  pygments "rrt" theme, based on Zap and Emacs defaults.
  
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
    Tok.keyword => "#ff0000",
    Tok.keyword_type => "#ee82ee",
    Tok.name_constant => "#7fffd4",
    Tok.name_function => "#ffff00",
    Tok.name_variable => "#eedd82",
    Tok.string => "#87ceeb",
    Tok.comment => "#00ff00",
    Tok.comment_preproc => "#e5e5e5",
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  def style() do
    Style.make_style(
      short_name: "rrt",
      long_name: "Rrt Style",
      background_color: "#000000",
      highlight_color: "#0000ff",
      styles: @styles)
  end
end