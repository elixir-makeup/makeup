
defmodule Makeup.Styles.HTML.SambaStyle do
  @moduledoc false

  require Makeup.Token.TokenTypes
  alias Makeup.Token.TokenTypes, as: Tok

  @styles %{
    Tok.error => "#a40000 border:#ef2929",
    Tok.other => "#000000",
    Tok.keyword => "bold #204a87",
    Tok.keyword_constant => "bold #204a87",
    Tok.keyword_declaration => "bold #204a87",
    Tok.keyword_namespace => "bold #204a87",
    Tok.keyword_pseudo => "bold #204a87",
    Tok.keyword_reserved => "bold #204a87",
    Tok.keyword_type => "bold #204a87",
    Tok.name => "#000000",
    Tok.name_attribute => "#c4a000",
    Tok.name_builtin => "#204a87",
    Tok.name_builtin_pseudo => "#3465a4",
    Tok.name_class => "#5c35cc",
    Tok.name_constant => "#000000",
    Tok.name_decorator => "bold #5c35cc",
    Tok.name_entity => "#ce5c00",
    Tok.name_exception => "bold #cc0000",
    Tok.name_function => "#000000",
    Tok.name_property => "#000000",
    Tok.name_label => "#f57900",
    Tok.name_namespace => "#000000",
    Tok.name_other => "#000000",
    Tok.name_tag => "bold #204a87",
    Tok.name_variable => "#000000",
    Tok.name_variable_class => "#000000",
    Tok.name_variable_global => "#000000",
    Tok.name_variable_instance => "#000000",
    Tok.literal => "#000000",
    Tok.string => "#4e9a06",
    Tok.string_backtick => "#4e9a06",
    Tok.string_char => "#4e9a06",
    Tok.string_doc => "italic #8f5902",
    Tok.string_double => "#4e9a06",
    Tok.string_escape => "#4e9a06",
    Tok.string_heredoc => "#4e9a06",
    Tok.string_interpol => "#4e9a06",
    Tok.string_other => "#4e9a06",
    Tok.string_regex => "#4e9a06",
    Tok.string_single => "#4e9a06",
    Tok.string_symbol => "#4e9a06",
    Tok.number => "bold #0000cf",
    Tok.number_float => "bold #0000cf",
    Tok.number_hex => "bold #0000cf",
    Tok.number_integer => "bold #0000cf",
    Tok.number_integer_long => "bold #0000cf",
    Tok.number_oct => "bold #0000cf",
    Tok.operator => "bold #ce5c00",
    Tok.operator_word => "bold #204a87",
    Tok.punctuation => "#000000",
    Tok.comment => "#8e908c",
    Tok.comment_multiline => "#8e908c",
    Tok.comment_preproc => "#8e908c",
    Tok.comment_single => "#8e908c",
    Tok.comment_special => "#8e908c",
    Tok.generic => "#000000",
    Tok.generic_deleted => "#a40000",
    Tok.generic_emph => "italic #000000",
    Tok.generic_error => "#ef2929",
    Tok.generic_heading => "bold #000080",
    Tok.generic_inserted => "#00A000",
    Tok.generic_output => "italic #000000",
    Tok.generic_prompt => "#8f5902",
    Tok.generic_strong => "bold #000000",
    Tok.generic_subheading => "bold #800080",
    Tok.generic_traceback => "bold #a40000"
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  @style_struct Style.make_style(
      short_name: "samba",
      long_name: "Samba Style",
      background_color: "#f8f8f8",
      highlight_color: "#ffffcc",
      styles: @styles)
      
  def style() do
    @style_struct()
  end
end