
defmodule Makeup.Styles.HTML.IgorStyle do
  @moduledoc false

  require Makeup.Token.TokenTypes
  alias Makeup.Token.TokenTypes, as: Tok

  @styles %{
    Tok.keyword => "#0000FF",
    Tok.name_class => "#007575",
    Tok.name_decorator => "#CC00A3",
    Tok.name_function => "#C34E00",
    Tok.string => "#009C00",
    Tok.comment => "italic #FF0000",
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  @style_struct Style.make_style(
      short_name: "igor",
      long_name: "Igor Style",
      background_color: "#ffffff",
      highlight_color: "#ffffcc",
      styles: @styles)
      
  def style() do
    @style_struct()
  end
end