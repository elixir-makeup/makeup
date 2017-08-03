
defmodule Makeup.Styles.HTML.PerldocStyle do
  @moduledoc false

  require Makeup.Token.TokenTypes
  alias Makeup.Token.TokenTypes, as: Tok

  @styles %{
    Tok.error => "bg:#e3d2d2 #a61717",
    Tok.keyword => "#8B008B bold",
    Tok.keyword_type => "#00688B",
    Tok.name_attribute => "#658b00",
    Tok.name_builtin => "#658b00",
    Tok.name_class => "#008b45 bold",
    Tok.name_constant => "#00688B",
    Tok.name_decorator => "#707a7c",
    Tok.name_exception => "#008b45 bold",
    Tok.name_function => "#008b45",
    Tok.name_namespace => "#008b45 underline",
    Tok.name_tag => "#8B008B bold",
    Tok.name_variable => "#00688B",
    Tok.string => "#CD5555",
    Tok.string_heredoc => "#1c7e71 italic",
    Tok.string_other => "#cb6c20",
    Tok.string_regex => "#1c7e71",
    Tok.number => "#B452CD",
    Tok.operator_word => "#8B008B",
    Tok.comment => "#228B22",
    Tok.comment_preproc => "#1e889b",
    Tok.comment_special => "#8B008B bold",
    Tok.generic_deleted => "#aa0000",
    Tok.generic_emph => "italic",
    Tok.generic_error => "#aa0000",
    Tok.generic_heading => "bold #000080",
    Tok.generic_inserted => "#00aa00",
    Tok.generic_output => "#888888",
    Tok.generic_prompt => "#555555",
    Tok.generic_strong => "bold",
    Tok.generic_subheading => "bold #800080",
    Tok.generic_traceback => "#aa0000"
    
  }
  
  alias Makeup.Styles.HTML.Style
  
  @style_struct Style.make_style(
      short_name: "perldoc",
      long_name: "Perldoc Style",
      background_color: "#eeeedd",
      highlight_color: "#ffffcc",
      styles: @styles)
      
  def style() do
    @style_struct()
  end
end