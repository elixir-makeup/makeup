
defmodule Makeup.Styles.HTML.LovelaceStyle do
  @moduledoc false

  require Makeup.Token.TokenTypes
  alias Makeup.Token.TokenTypes, as: Tok

  @styles %{
    Tok.error => "bg:#a848a8",
    Tok.keyword => "#2838b0",
    Tok.keyword_constant => "italic #444444",
    Tok.keyword_declaration => "italic",
    Tok.keyword_type => "italic",
    Tok.name_attribute => "#388038",
    Tok.name_builtin => "#388038",
    Tok.name_builtin_pseudo => "italic",
    Tok.name_class => "#287088",
    Tok.name_constant => "#b85820",
    Tok.name_decorator => "#287088",
    Tok.name_entity => "#709030",
    Tok.name_exception => "#908828",
    Tok.name_function => "#785840",
    Tok.name_function_magic => "#b85820",
    Tok.name_label => "#289870",
    Tok.name_namespace => "#289870",
    Tok.name_tag => "#2838b0",
    Tok.name_variable => "#b04040",
    Tok.name_variable_global => "#908828",
    Tok.name_variable_magic => "#b85820",
    Tok.string => "#b83838",
    Tok.string_affix => "#444444",
    Tok.string_char => "#a848a8",
    Tok.string_delimiter => "#b85820",
    Tok.string_doc => "italic #b85820",
    Tok.string_escape => "#709030",
    Tok.string_interpol => "underline",
    Tok.string_other => "#a848a8",
    Tok.string_regex => "#a848a8",
    Tok.number => "#444444",
    Tok.operator => "#666666",
    Tok.operator_word => "#a848a8",
    Tok.punctuation => "#888888",
    Tok.comment => "italic #888888",
    Tok.comment_hashbang => "#287088",
    Tok.comment_multiline => "#888888",
    Tok.comment_preproc => "noitalic #289870",
    Tok.generic_deleted => "#c02828",
    Tok.generic_emph => "italic",
    Tok.generic_error => "#c02828",
    Tok.generic_heading => "#666666",
    Tok.generic_inserted => "#388038",
    Tok.generic_output => "#666666",
    Tok.generic_prompt => "#444444",
    Tok.generic_strong => "bold",
    Tok.generic_subheading => "#444444",
    Tok.generic_traceback => "#2838b0"
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  @style_struct Style.make_style(
      short_name: "lovelace",
      long_name: "Lovelace Style",
      background_color: "#ffffff",
      highlight_color: "#ffffcc",
      styles: @styles)
      
  def style() do
    @style_struct()
  end
end