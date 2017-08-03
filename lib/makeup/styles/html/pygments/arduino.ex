
defmodule Makeup.Styles.HTML.ArduinoStyle do
  @moduledoc false

  require Makeup.Token.TokenTypes
  alias Makeup.Token.TokenTypes, as: Tok

  @styles %{
    Tok.error => "#a61717",
    Tok.keyword => "#728E00",
    Tok.keyword_constant => "#00979D",
    Tok.keyword_pseudo => "#00979D",
    Tok.keyword_reserved => "#00979D",
    Tok.keyword_type => "#00979D",
    Tok.name => "#434f54",
    Tok.name_builtin => "#728E00",
    Tok.name_function => "#D35400",
    Tok.name_other => "#728E00",
    Tok.string => "#7F8C8D",
    Tok.number => "#8A7B52",
    Tok.operator => "#728E00",
    Tok.comment => "#95a5a6",
    Tok.comment_preproc => "#728E00",
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  @style_struct Style.make_style(
      short_name: "arduino",
      long_name: "Arduino Style",
      background_color: "#ffffff",
      highlight_color: "#ffffcc",
      styles: @styles)
      
  def style() do
    @style_struct()
  end
end