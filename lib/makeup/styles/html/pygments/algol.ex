
defmodule Makeup.Styles.HTML.AlgolStyle do
  @moduledoc """
  Algol publication style.
  
  This style renders source code for publication of algorithms in
  scientific papers and academic texts, where its format is frequently used.
  
  It is based on the style of the revised Algol-60 language report[1].
  
  o  No colours, only black, white and shades of grey are used.
  o  Keywords are rendered in lowercase underline boldface.
  o  Builtins are rendered in lowercase boldface italic.
  o  Docstrings and pragmas are rendered in dark grey boldface.
  o  Library identifiers are rendered in dark grey boldface italic.
  o  Comments are rendered in grey italic.
  
  To render keywords without underlining, refer to the `Algol_Nu` style.
  
  For lowercase conversion of keywords and builtins in languages where
  these are not or might not be lowercase, a supporting lexer is required.
  The Algol and Modula-2 lexers automatically convert to lowercase whenever
  this style is selected.
  
  [1] `Revised Report on the Algorithmic Language Algol-60 <http://www.masswerk.at/algol60/report.htm>`
  
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
  
  def style() do
    Style.make_style(
      short_name: "algol",
      long_name: "Algol Style",
      background_color: "#ffffff",
      highlight_color: "#ffffcc",
      styles: @styles)
  end
end