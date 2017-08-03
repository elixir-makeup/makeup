
defmodule Makeup.Styles.HTML.ManniStyle do
  @moduledoc false

  require Makeup.Token.TokenTypes
  alias Makeup.Token.TokenTypes, as: Tok

  @styles %{
    Tok.error => "bg:#FFAAAA #AA0000",
    Tok.keyword => "bold #006699",
    Tok.keyword_pseudo => "nobold",
    Tok.keyword_type => "#007788",
    Tok.name_attribute => "#330099",
    Tok.name_builtin => "#336666",
    Tok.name_class => "bold #00AA88",
    Tok.name_constant => "#336600",
    Tok.name_decorator => "#9999FF",
    Tok.name_entity => "bold #999999",
    Tok.name_exception => "bold #CC0000",
    Tok.name_function => "#CC00FF",
    Tok.name_label => "#9999FF",
    Tok.name_namespace => "bold #00CCFF",
    Tok.name_tag => "bold #330099",
    Tok.name_variable => "#003333",
    Tok.string => "#CC3300",
    Tok.string_doc => "italic",
    Tok.string_escape => "bold #CC3300",
    Tok.string_interpol => "#AA0000",
    Tok.string_other => "#CC3300",
    Tok.string_regex => "#33AAAA",
    Tok.string_symbol => "#FFCC33",
    Tok.number => "#FF6600",
    Tok.operator => "#555555",
    Tok.operator_word => "bold #000000",
    Tok.comment => "italic #0099FF",
    Tok.comment_preproc => "noitalic #009999",
    Tok.comment_special => "bold",
    Tok.generic_deleted => "border:#CC0000 bg:#FFCCCC",
    Tok.generic_emph => "italic",
    Tok.generic_error => "#FF0000",
    Tok.generic_heading => "bold #003300",
    Tok.generic_inserted => "border:#00CC00 bg:#CCFFCC",
    Tok.generic_output => "#AAAAAA",
    Tok.generic_prompt => "bold #000099",
    Tok.generic_strong => "bold",
    Tok.generic_subheading => "bold #003300",
    Tok.generic_traceback => "#99CC66"
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  @style_struct Style.make_style(
      short_name: "manni",
      long_name: "Manni Style",
      background_color: "#f0f3f3",
      highlight_color: "#ffffcc",
      styles: @styles)
      
  def style() do
    @style_struct()
  end
end