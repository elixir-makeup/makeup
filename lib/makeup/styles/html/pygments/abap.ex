
defmodule Makeup.Styles.HTML.AbapStyle do
  @moduledoc false

  require Makeup.Token.TokenTypes
  alias Makeup.Token.TokenTypes, as: Tok

  @styles %{
    Tok.error => "#F00",
    Tok.keyword => "#00f",
    Tok.name => "#000",
    Tok.string => "#5a2",
    Tok.number => "#3af",
    Tok.operator_word => "#00f",
    Tok.comment => "italic #888",
    Tok.comment_special => "#888",
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  @style_struct Style.make_style(
      short_name: "abap",
      long_name: "Abap Style",
      background_color: "#ffffff",
      highlight_color: "#ffffcc",
      styles: @styles)
      
  def style() do
    @style_struct()
  end
end