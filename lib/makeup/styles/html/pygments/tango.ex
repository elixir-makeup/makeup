
defmodule Makeup.Styles.HTML.TangoStyle do
  @moduledoc """
  The Crunchy default Style inspired from the color palette from
  the Tango Icon Theme Guidelines.
  
  http://tango.freedesktop.org/Tango_Icon_Theme_Guidelines
  
  Butter:     #fce94f     #edd400     #c4a000
  Orange:     #fcaf3e     #f57900     #ce5c00
  Chocolate:  #e9b96e     #c17d11     #8f5902
  Chameleon:  #8ae234     #73d216     #4e9a06
  Sky Blue:   #729fcf     #3465a4     #204a87
  Plum:       #ad7fa8     #75507b     #5c35cc
  Scarlet Red:#ef2929     #cc0000     #a40000
  Aluminium:  #eeeeec     #d3d7cf     #babdb6
              #888a85     #555753     #2e3436
  
  Not all of the above colors are used; other colors added:
      very light grey: #f8f8f8  (for background)
  
  This style can be used as a template as it includes all the known
  Token types, unlike most (if not all) of the styles included in the
  Pygments distribution.
  
  However, since Crunchy is intended to be used by beginners, we have strived
  to create a style that gloss over subtle distinctions between different
  categories.
  
  Taking Python for example, comments (Comment.\*) and docstrings (String.Doc)
  have been chosen to have the same style.  Similarly, keywords (Keyword.\*),
  and Operator.Word (and, or, in) have been assigned the same style.
  
  &copy; Copyright 2006-2017 by the Pygments team, see AUTHORS.
  License: BSD, see [here](https://opensource.org/licenses/BSD-3-Clause) for details.

  <table>
    <thead><tr><th>Warning</th></tr></thead>
    <tbody><tr><td>
      This file was automatically generated from the Pygments source.
      Any edits to this file may be lost if the file is regenerated.
    </td></tr></tbody>
  </table>
  """

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
    Tok.name_class => "#000000",
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
    Tok.punctuation => "bold #000000",
    Tok.comment => "italic #8f5902",
    Tok.comment_multiline => "italic #8f5902",
    Tok.comment_preproc => "italic #8f5902",
    Tok.comment_single => "italic #8f5902",
    Tok.comment_special => "italic #8f5902",
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
  
  def style() do
    Style.make_style(
      short_name: "tango",
      long_name: "Tango Style",
      background_color: "#f8f8f8",
      highlight_color: "#ffffcc",
      styles: @styles)
  end
end