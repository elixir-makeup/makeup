
defmodule Makeup.Styles.HTML.AlgolStyle do
  @moduledoc false

  require Makeup.Token.TokenTypes
  alias Makeup.Token.TokenTypes, as: Tok

  @styles %{
    Tok.error => "border:#FF0000",
    Tok.keyword => "underline bold",
    Tok.keyword_declaration => "italic",
    Tok.name_builtin => "bold italic",
    Tok.name_builtin_pseudo => "bold italic",
    Tok.name_class => "bold italic #666",
    Tok.name_constant => "bold italic #666",
    Tok.name_function => "bold italic #666",
    Tok.name_namespace => "bold italic #666",
    Tok.name_variable => "bold italic #666",
    Tok.string => "italic #666",
    Tok.operator_word => "bold",
    Tok.comment => "italic #888",
    Tok.comment_preproc => "bold noitalic #888",
    Tok.comment_special => "bold noitalic #888",
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  @style_struct Style.make_style(
      short_name: "algol",
      long_name: "Algol Style",
      background_color: "#ffffff",
      highlight_color: "#ffffcc",
      styles: @styles)
      
  def style() do
    @style_struct()
  end
end