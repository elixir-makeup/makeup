defmodule Makeup.Token.Utils do

  use Const

  require Makeup.Token.TokenTypes
  alias Makeup.Token.TokenTypes, as: Tok

  alias Makeup.Token.Utils.Hierarchy

  @hierarchy [
    {Tok.text, nil},
    {Tok.whitespace, "w"},
    {Tok.escape, "esc"},
    {Tok.error, "err"},
    {Tok.other, "x"},

    {Tok.comment, "c", [
      {Tok.comment_hashbang, "ch"},
      {Tok.comment_multiline, "cm"},
      {Tok.comment_preproc, "cp", [
        {Tok.comment_preproc_file, "cpf"}]},
      {Tok.comment_single, "c1"},
      {Tok.comment_special, "cs"}]},

    {Tok.keyword, "k", [
      {Tok.keyword_constant, "kc"},
      {Tok.keyword_declaration, "kd"},
      {Tok.keyword_namespace, "kn"},
      {Tok.keyword_pseudo, "kp"},
      {Tok.keyword_reserved, "kr"},
      {Tok.keyword_type, "kt"}]},

    {Tok.literal, "l", [
      {Tok.literal_date, "ld"}]},

    {Tok.name, "n", [
      {Tok.name_attribute, "na"},
      {Tok.name_builtin, "nb", [
        {Tok.name_builtin_pseudo, "bp"}]},
      {Tok.name_class, "nc"},
      {Tok.name_constant, "no"},
      {Tok.name_decorator, "nd"},
      {Tok.name_entity, "ni"},
      {Tok.name_exception, "ne"},
      {Tok.name_function, "nf", [
        {Tok.name_function_magic, "fm"}]},
      {Tok.name_property, "py"},
      {Tok.name_label, "nl"},
      {Tok.name_namespace, "nn"},
      {Tok.name_other, "nx"},
      {Tok.name_tag, "nt"},
      {Tok.name_variable, "nv", [
        {Tok.name_variable_class, "vc"},
        {Tok.name_variable_global, "vg"},
        {Tok.name_variable_instance, "vi"},
        {Tok.name_variable_magic, "vm"}]}]},

    {Tok.number, "m", [
      {Tok.number_bin, "mb"},
      {Tok.number_float, "mf"},
      {Tok.number_hex, "mh"},
      {Tok.number_integer, "mi", [
        {Tok.number_integer_long, "il"}]},
      {Tok.number_oct, "mo"}]},

    {Tok.string, "s", [
      {Tok.string_affix, "sa"},
      {Tok.string_backtick, "sb"},
      {Tok.string_char, "sc"},
      {Tok.string_delimiter, "dl"},
      {Tok.string_doc, "sd"},
      {Tok.string_double, "s2"},
      {Tok.string_escape, "se"},
      {Tok.string_heredoc, "sh"},
      {Tok.string_interpol, "si"},
      {Tok.string_other, "sx"},
      {Tok.string_regex, "sr"},
      {Tok.string_sigil, "sx"},
      {Tok.string_single, "s1"},
      {Tok.string_symbol, "ss"}]},

    {Tok.operator, "o", [
      {Tok.operator_word, "ow"}]},

    {Tok.punctuation, "p"},

    {Tok.generic, "g", [
      {Tok.generic_deleted, "gd"},
      {Tok.generic_emph, "ge"},
      {Tok.generic_error, "gr"},
      {Tok.generic_heading, "gh"},
      {Tok.generic_inserted, "gi"},
      {Tok.generic_prompt, "gp"},
      {Tok.generic_output, "go"},
      {Tok.generic_strong, "gs"},
      {Tok.generic_subheading, "gu"},
      {Tok.generic_traceback, "gt"}]}
  ]

  
  @token_to_class_map Hierarchy.style_to_class_map(@hierarchy)

  const precedence, do:
    Hierarchy.hierarchy_to_precedence(@hierarchy)
  const token_to_class_map, do:
    @token_to_class_map
  const standard_token_types, do:
    Map.keys(@token_to_class_map)


  def css_class_for_token_type(token_type) do
   Map.get(@token_to_class_map, token_type, nil)
  end

end