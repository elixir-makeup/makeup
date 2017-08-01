defmodule Makeup.Token.TokenTypes do
  import Makeup.Token.DefTokenType, only: [deftokentype: 1]

  @doc """
  Normal text with no highlighting.
  """
  deftokentype text
  
  @doc """
  Whitespace you want to see highlighted.
  """
  deftokentype whitespace

  @doc """
  Add meaning of `escape`...
  """
  deftokentype escape

  @doc """
  Add meaning of `error`...
  """
  deftokentype error

  @doc """
  Add meaning of `other`...
  """
  deftokentype other


  @doc """
  Add meaning of `keyword`...
  """
  deftokentype keyword

  @doc """
  Add meaning of `keyword_constant`...
  """
  deftokentype keyword_constant

  @doc """
  Add meaning of `keyword_declaration`...
  """
  deftokentype keyword_declaration

  @doc """
  Add meaning of `keyword_namespace`...
  """
  deftokentype keyword_namespace

  @doc """
  Add meaning of `keyword_pseudo`...
  """
  deftokentype keyword_pseudo

  @doc """
  Add meaning of `keyword_reserved`...
  """
  deftokentype keyword_reserved

  @doc """
  Add meaning of `keyword_type`...
  """
  deftokentype keyword_type


  @doc """
  Add meaning of `name`...
  """
  deftokentype name

  @doc """
  Add meaning of `name_attribute`...
  """
  deftokentype name_attribute

  @doc """
  Add meaning of `name_builtin`...
  """
  deftokentype name_builtin

  @doc """
  Add meaning of `name_builtin_pseudo`...
  """
  deftokentype name_builtin_pseudo

  @doc """
  Add meaning of `name_class`...
  """
  deftokentype name_class

  @doc """
  Add meaning of `name_constant`...
  """
  deftokentype name_constant

  @doc """
  Add meaning of `name_decorator`...
  """
  deftokentype name_decorator

  @doc """
  Add meaning of `name_entity`...
  """
  deftokentype name_entity

  @doc """
  Add meaning of `name_exception`...
  """
  deftokentype name_exception

  @doc """
  Add meaning of `name_function`...
  """
  deftokentype name_function

  @doc """
  Add meaning of `name_function_magic`...
  """
  deftokentype name_function_magic

  @doc """
  Add meaning of `name_property`...
  """
  deftokentype name_property

  @doc """
  Add meaning of `name_label`...
  """
  deftokentype name_label

  @doc """
  Add meaning of `name_namespace`...
  """
  deftokentype name_namespace

  @doc """
  Add meaning of `name_other`...
  """
  deftokentype name_other

  @doc """
  Add meaning of `name_tag`...
  """
  deftokentype name_tag

  @doc """
  Add meaning of `name_variable`...
  """
  deftokentype name_variable

  @doc """
  Add meaning of `name_variable_class`...
  """
  deftokentype name_variable_class

  @doc """
  Add meaning of `name_variable_global`...
  """
  deftokentype name_variable_global

  @doc """
  Add meaning of `name_variable_instance`...
  """
  deftokentype name_variable_instance

  @doc """
  Add meaning of `name_variable_magic`...
  """
  deftokentype name_variable_magic


  @doc """
  Add meaning of `literal`...
  """
  deftokentype literal

  @doc """
  Add meaning of `literal_date`...
  """
  deftokentype literal_date


  @doc """
  Add meaning of `string`...
  """
  deftokentype string

  @doc """
  Add meaning of `string_affix`...
  """
  deftokentype string_affix

  @doc """
  Add meaning of `string_backtick`...
  """
  deftokentype string_backtick

  @doc """
  Add meaning of `string_char`...
  """
  deftokentype string_char

  @doc """
  Add meaning of `string_delimiter`...
  """
  deftokentype string_delimiter

  @doc """
  Add meaning of `string_doc`...
  """
  deftokentype string_doc

  @doc """
  Add meaning of `string_double`...
  """
  deftokentype string_double

  @doc """
  Add meaning of `string_escape`...
  """
  deftokentype string_escape

  @doc """
  Add meaning of `string_heredoc`...
  """
  deftokentype string_heredoc

  @doc """
  Add meaning of `string_interpol`...
  """
  deftokentype string_interpol

  @doc """
  Add meaning of `string_other`...
  """
  deftokentype string_other

  @doc """
  Add meaning of `string_regex`...
  """
  deftokentype string_regex

  @doc """
  Add meaning of `string_single`...
  """
  deftokentype string_sigil

  @doc """
  Add meaning of `string_single`...
  """
  deftokentype string_single

  @doc """
  Add meaning of `string_symbol`...
  """
  deftokentype string_symbol


  @doc """
  Add meaning of `number`...
  """
  deftokentype number

  @doc """
  Add meaning of `number_bin`...
  """
  deftokentype number_bin

  @doc """
  Add meaning of `number_float`...
  """
  deftokentype number_float

  @doc """
  Add meaning of `number_hex`...
  """
  deftokentype number_hex

  @doc """
  Add meaning of `number_integer`...
  """
  deftokentype number_integer

  @doc """
  Add meaning of `number_integer_long`...
  """
  deftokentype number_integer_long

  @doc """
  Add meaning of `number_oct`...
  """
  deftokentype number_oct


  @doc """
  Add meaning of `operator`...
  """
  deftokentype operator

  @doc """
  Add meaning of `operator_word`...
  """
  deftokentype operator_word


  @doc """
  Add meaning of `punctuation`...
  """
  deftokentype punctuation


  @doc """
  Add meaning of `comment`...
  """
  deftokentype comment

  @doc """
  Add meaning of `comment_hashbang`...
  """
  deftokentype comment_hashbang

  @doc """
  Add meaning of `comment_multiline`...
  """
  deftokentype comment_multiline

  @doc """
  Add meaning of `comment_preproc`...
  """
  deftokentype comment_preproc

  @doc """
  Add meaning of `comment_preproc_file`...
  """
  deftokentype comment_preproc_file

  @doc """
  Add meaning of `comment_single`...
  """
  deftokentype comment_single

  @doc """
  Add meaning of `comment_special`...
  """
  deftokentype comment_special


  @doc """
  Add meaning of `generic`...
  """
  deftokentype generic

  @doc """
  Add meaning of `generic_deleted`...
  """
  deftokentype generic_deleted

  @doc """
  Add meaning of `generic_emph`...
  """
  deftokentype generic_emph

  @doc """
  Add meaning of `generic_error`...
  """
  deftokentype generic_error

  @doc """
  Add meaning of `generic_heading`...
  """
  deftokentype generic_heading

  @doc """
  Add meaning of `generic_inserted`...
  """
  deftokentype generic_inserted

  @doc """
  Add meaning of `generic_output`...
  """
  deftokentype generic_output

  @doc """
  Add meaning of `generic_prompt`...
  """
  deftokentype generic_prompt

  @doc """
  Add meaning of `generic_strong`...
  """
  deftokentype generic_strong

  @doc """
  Add meaning of `generic_subheading`...
  """
  deftokentype generic_subheading

  @doc """
  Add meaning of `generic_traceback`...
  """
  deftokentype generic_traceback

end