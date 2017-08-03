
defmodule Makeup.Styles.HTML.VimStyle do
  @moduledoc false

  require Makeup.Token.TokenTypes
  alias Makeup.Token.TokenTypes, as: Tok

  @styles %{
    Tok.error => "border:#FF0000",
    Tok.keyword => "#cdcd00",
    Tok.keyword_declaration => "#00cd00",
    Tok.keyword_namespace => "#cd00cd",
    Tok.keyword_type => "#00cd00",
    Tok.name_builtin => "#cd00cd",
    Tok.name_class => "#00cdcd",
    Tok.name_exception => "bold #666699",
    Tok.name_variable => "#00cdcd",
    Tok.string => "#cd0000",
    Tok.number => "#cd00cd",
    Tok.operator => "#3399cc",
    Tok.operator_word => "#cdcd00",
    Tok.comment => "#000080",
    Tok.comment_special => "bold #cd0000",
    Tok.generic_deleted => "#cd0000",
    Tok.generic_emph => "italic",
    Tok.generic_error => "#FF0000",
    Tok.generic_heading => "bold #000080",
    Tok.generic_inserted => "#00cd00",
    Tok.generic_output => "#888",
    Tok.generic_prompt => "bold #000080",
    Tok.generic_strong => "bold",
    Tok.generic_subheading => "bold #800080",
    Tok.generic_traceback => "#04D"
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  @style_struct Style.make_style(
      short_name: "vim",
      long_name: "Vim Style",
      background_color: "#000000",
      highlight_color: "#222222",
      styles: @styles)
      
  def style() do
    @style_struct()
  end
end