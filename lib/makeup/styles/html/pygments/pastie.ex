
defmodule Makeup.Styles.HTML.PastieStyle do
  @moduledoc false

  require Makeup.Token.TokenTypes
  alias Makeup.Token.TokenTypes, as: Tok

  @styles %{
    Tok.error => "bg:#e3d2d2 #a61717",
    Tok.keyword => "bold #008800",
    Tok.keyword_pseudo => "nobold",
    Tok.keyword_type => "#888888",
    Tok.name_attribute => "#336699",
    Tok.name_builtin => "#003388",
    Tok.name_class => "bold #bb0066",
    Tok.name_constant => "bold #003366",
    Tok.name_decorator => "#555555",
    Tok.name_exception => "bold #bb0066",
    Tok.name_function => "bold #0066bb",
    Tok.name_property => "bold #336699",
    Tok.name_label => "italic #336699",
    Tok.name_namespace => "bold #bb0066",
    Tok.name_tag => "bold #bb0066",
    Tok.name_variable => "#336699",
    Tok.name_variable_class => "#336699",
    Tok.name_variable_global => "#dd7700",
    Tok.name_variable_instance => "#3333bb",
    Tok.string => "bg:#fff0f0 #dd2200",
    Tok.string_escape => "#0044dd",
    Tok.string_interpol => "#3333bb",
    Tok.string_other => "bg:#f0fff0 #22bb22",
    Tok.string_regex => "bg:#fff0ff #008800",
    Tok.string_symbol => "#aa6600",
    Tok.number => "bold #0000DD",
    Tok.operator_word => "#008800",
    Tok.comment => "#888888",
    Tok.comment_preproc => "bold #cc0000",
    Tok.comment_special => "bg:#fff0f0 bold #cc0000",
    Tok.generic_deleted => "bg:#ffdddd #000000",
    Tok.generic_emph => "italic",
    Tok.generic_error => "#aa0000",
    Tok.generic_heading => "#333",
    Tok.generic_inserted => "bg:#ddffdd #000000",
    Tok.generic_output => "#888888",
    Tok.generic_prompt => "#555555",
    Tok.generic_strong => "bold",
    Tok.generic_subheading => "#666",
    Tok.generic_traceback => "#aa0000"
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  @style_struct Style.make_style(
      short_name: "pastie",
      long_name: "Pastie Style",
      background_color: "#ffffff",
      highlight_color: "#ffffcc",
      styles: @styles)
      
  def style() do
    @style_struct()
  end
end