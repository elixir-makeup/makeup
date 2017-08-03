
defmodule Makeup.Styles.HTML.FruityStyle do
  @moduledoc false

  require Makeup.Token.TokenTypes
  alias Makeup.Token.TokenTypes, as: Tok

  @styles %{
    Tok.keyword => "#fb660a bold",
    Tok.keyword_pseudo => "nobold",
    Tok.keyword_type => "#cdcaa9 bold",
    Tok.name_attribute => "#ff0086 bold",
    Tok.name_constant => "#0086d2",
    Tok.name_function => "#ff0086 bold",
    Tok.name_tag => "#fb660a bold",
    Tok.name_variable => "#fb660a",
    Tok.string => "#0086d2",
    Tok.number => "#0086f7 bold",
    Tok.comment => "#008800 bg:#0f140f italic",
    Tok.comment_preproc => "#ff0007 bold",
    Tok.generic_heading => "#ffffff bold",
    Tok.generic_output => "#444444 bg:#222222",
    Tok.generic_subheading => "#ffffff bold",
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  @style_struct Style.make_style(
      short_name: "fruity",
      long_name: "Fruity Style",
      background_color: "#111111",
      highlight_color: "#333333",
      styles: @styles)
      
  def style() do
    @style_struct()
  end
end