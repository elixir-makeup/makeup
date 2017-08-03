
defmodule Makeup.Styles.HTML.BorlandStyle do
  @moduledoc false

  require Makeup.Token.TokenTypes
  alias Makeup.Token.TokenTypes, as: Tok

  @styles %{
    Tok.error => "bg:#e3d2d2 #a61717",
    Tok.keyword => "bold #000080",
    Tok.name_attribute => "#FF0000",
    Tok.name_tag => "bold #000080",
    Tok.string => "#0000FF",
    Tok.string_char => "#800080",
    Tok.number => "#0000FF",
    Tok.operator_word => "bold",
    Tok.comment => "italic #008800",
    Tok.comment_preproc => "noitalic #008080",
    Tok.comment_special => "noitalic bold",
    Tok.generic_deleted => "bg:#ffdddd #000000",
    Tok.generic_emph => "italic",
    Tok.generic_error => "#aa0000",
    Tok.generic_heading => "#999999",
    Tok.generic_inserted => "bg:#ddffdd #000000",
    Tok.generic_output => "#888888",
    Tok.generic_prompt => "#555555",
    Tok.generic_strong => "bold",
    Tok.generic_subheading => "#aaaaaa",
    Tok.generic_traceback => "#aa0000"
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  @style_struct Style.make_style(
      short_name: "borland",
      long_name: "Borland Style",
      background_color: "#ffffff",
      highlight_color: "#ffffcc",
      styles: @styles)
      
  def style() do
    @style_struct()
  end
end