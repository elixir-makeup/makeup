
defmodule Makeup.Styles.HTML.FriendlyStyle do
  @moduledoc false

  require Makeup.Token.TokenTypes
  alias Makeup.Token.TokenTypes, as: Tok

  @styles %{
    Tok.error => "border:#FF0000",
    Tok.keyword => "bold #007020",
    Tok.keyword_pseudo => "nobold",
    Tok.keyword_type => "nobold #902000",
    Tok.name_attribute => "#4070a0",
    Tok.name_builtin => "#007020",
    Tok.name_class => "bold #0e84b5",
    Tok.name_constant => "#60add5",
    Tok.name_decorator => "bold #555555",
    Tok.name_entity => "bold #d55537",
    Tok.name_exception => "#007020",
    Tok.name_function => "#06287e",
    Tok.name_label => "bold #002070",
    Tok.name_namespace => "bold #0e84b5",
    Tok.name_tag => "bold #062873",
    Tok.name_variable => "#bb60d5",
    Tok.string => "#4070a0",
    Tok.string_doc => "italic",
    Tok.string_escape => "bold #4070a0",
    Tok.string_interpol => "italic #70a0d0",
    Tok.string_other => "#c65d09",
    Tok.string_regex => "#235388",
    Tok.string_symbol => "#517918",
    Tok.number => "#40a070",
    Tok.operator => "#666666",
    Tok.operator_word => "bold #007020",
    Tok.comment => "italic #60a0b0",
    Tok.comment_preproc => "noitalic #007020",
    Tok.comment_special => "noitalic bg:#fff0f0",
    Tok.generic_deleted => "#A00000",
    Tok.generic_emph => "italic",
    Tok.generic_error => "#FF0000",
    Tok.generic_heading => "bold #000080",
    Tok.generic_inserted => "#00A000",
    Tok.generic_output => "#888",
    Tok.generic_prompt => "bold #c65d09",
    Tok.generic_strong => "bold",
    Tok.generic_subheading => "bold #800080",
    Tok.generic_traceback => "#04D"
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  @style_struct Style.make_style(
      short_name: "friendly",
      long_name: "Friendly Style",
      background_color: "#f0f0f0",
      highlight_color: "#ffffcc",
      styles: @styles)
      
  def style() do
    @style_struct()
  end
end