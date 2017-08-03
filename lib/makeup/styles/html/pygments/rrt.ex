
defmodule Makeup.Styles.HTML.RrtStyle do
  @moduledoc false

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
  
  @style_struct Style.make_style(
      short_name: "rrt",
      long_name: "Rrt Style",
      background_color: "#000000",
      highlight_color: "#0000ff",
      styles: @styles)
      
  def style() do
    @style_struct()
  end
end