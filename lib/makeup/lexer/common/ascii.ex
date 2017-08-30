
defmodule Makeup.Lexer.Common.ASCII do
  @moduledoc """
  Helpers to work with ASCII character classes
  """
  
  alias Makeup.Lexer.Common.Macros, as: M
  require M

  @doc """
  Recognizes an ASCII space (`[?\\s, ?\\t, ?\\n, ?\\r, ?\\f, ?\\v]`).
  """
  defmacro space(ast_context) do
    quote do
      M.char(unquote(ast_context), [?\s, ?\t, ?\n, ?\r, ?\f, ?\v])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII spaces (`[?\\s, ?\\t, ?\\n, ?\\r, ?\\f, ?\\v]`).
  """
  defmacro spaces(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?\s, ?\t, ?\n, ?\r, ?\f, ?\v], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII spaces (`[?\\s, ?\\t, ?\\n, ?\\r, ?\\f, ?\\v]`).
  """
  defmacro spaces1(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?\s, ?\t, ?\n, ?\r, ?\f, ?\v], 1)
    end
  end

  

  @doc """
  Recognizes an ASCII letter (`[?A..?Z, ?a..?z]`).
  """
  defmacro letter(ast_context) do
    quote do
      M.char(unquote(ast_context), [?A..?Z, ?a..?z])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII letters (`[?A..?Z, ?a..?z]`).
  """
  defmacro letters(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?A..?Z, ?a..?z], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII letters (`[?A..?Z, ?a..?z]`).
  """
  defmacro letters1(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?A..?Z, ?a..?z], 1)
    end
  end

  
  @doc """
  Recognizes an ASCII letters (`[?A..?Z, ?a..?z]`) or an underscore (`?_`).
  """
  defmacro letter_(ast_context) do
    quote do
      M.char(unquote(ast_context), [?A..?Z, ?a..?z, ?_])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII letters (`[?A..?Z, ?a..?z]`) or underscores (`?_`).
  """
  defmacro letters_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?A..?Z, ?a..?z, ?_], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII letters (`[?A..?Z, ?a..?z]`) or underscores (`?_`).
  """
  defmacro letters1_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?A..?Z, ?a..?z, ?_], 1)
    end
  end
  

  @doc """
  Recognizes an ASCII lowercase letter (`[?a..?z]`).
  """
  defmacro lowercase_letter(ast_context) do
    quote do
      M.char(unquote(ast_context), [?a..?z])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII lowercase letters (`[?a..?z]`).
  """
  defmacro lowercase_letters(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?a..?z], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII lowercase letters (`[?a..?z]`).
  """
  defmacro lowercase_letters1(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?a..?z], 1)
    end
  end

  
  @doc """
  Recognizes an ASCII lowercase letters (`[?a..?z]`) or an underscore (`?_`).
  """
  defmacro lowercase_letter_(ast_context) do
    quote do
      M.char(unquote(ast_context), [?a..?z, ?_])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII lowercase letters (`[?a..?z]`) or underscores (`?_`).
  """
  defmacro lowercase_letters_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?a..?z, ?_], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII lowercase letters (`[?a..?z]`) or underscores (`?_`).
  """
  defmacro lowercase_letters1_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?a..?z, ?_], 1)
    end
  end
  

  @doc """
  Recognizes an ASCII uppercase letter (`[?A..?Z]`).
  """
  defmacro uppercase_letter(ast_context) do
    quote do
      M.char(unquote(ast_context), [?A..?Z])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII uppercase letters (`[?A..?Z]`).
  """
  defmacro uppercase_letters(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?A..?Z], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII uppercase letters (`[?A..?Z]`).
  """
  defmacro uppercase_letters1(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?A..?Z], 1)
    end
  end

  
  @doc """
  Recognizes an ASCII uppercase letters (`[?A..?Z]`) or an underscore (`?_`).
  """
  defmacro uppercase_letter_(ast_context) do
    quote do
      M.char(unquote(ast_context), [?A..?Z, ?_])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII uppercase letters (`[?A..?Z]`) or underscores (`?_`).
  """
  defmacro uppercase_letters_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?A..?Z, ?_], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII uppercase letters (`[?A..?Z]`) or underscores (`?_`).
  """
  defmacro uppercase_letters1_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?A..?Z, ?_], 1)
    end
  end
  

  @doc """
  Recognizes an ASCII alphanum (`[?A..?Z, ?a..?z, ?0..?9]`).
  """
  defmacro alphanum(ast_context) do
    quote do
      M.char(unquote(ast_context), [?A..?Z, ?a..?z, ?0..?9])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII alphanums (`[?A..?Z, ?a..?z, ?0..?9]`).
  """
  defmacro alphanums(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?A..?Z, ?a..?z, ?0..?9], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII alphanums (`[?A..?Z, ?a..?z, ?0..?9]`).
  """
  defmacro alphanums1(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?A..?Z, ?a..?z, ?0..?9], 1)
    end
  end

  
  @doc """
  Recognizes an ASCII alphanums (`[?A..?Z, ?a..?z, ?0..?9]`) or an underscore (`?_`).
  """
  defmacro alphanum_(ast_context) do
    quote do
      M.char(unquote(ast_context), [?A..?Z, ?a..?z, ?0..?9, ?_])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII alphanums (`[?A..?Z, ?a..?z, ?0..?9]`) or underscores (`?_`).
  """
  defmacro alphanums_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?A..?Z, ?a..?z, ?0..?9, ?_], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII alphanums (`[?A..?Z, ?a..?z, ?0..?9]`) or underscores (`?_`).
  """
  defmacro alphanums1_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?A..?Z, ?a..?z, ?0..?9, ?_], 1)
    end
  end
  

  @doc """
  Recognizes an ASCII lowercase alphanum (`[?a..?z, ?0..?9]`).
  """
  defmacro lowercase_alphanum(ast_context) do
    quote do
      M.char(unquote(ast_context), [?a..?z, ?0..?9])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII lowercase alphanums (`[?a..?z, ?0..?9]`).
  """
  defmacro lowercase_alphanums(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?a..?z, ?0..?9], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII lowercase alphanums (`[?a..?z, ?0..?9]`).
  """
  defmacro lowercase_alphanums1(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?a..?z, ?0..?9], 1)
    end
  end

  
  @doc """
  Recognizes an ASCII lowercase alphanums (`[?a..?z, ?0..?9]`) or an underscore (`?_`).
  """
  defmacro lowercase_alphanum_(ast_context) do
    quote do
      M.char(unquote(ast_context), [?a..?z, ?0..?9, ?_])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII lowercase alphanums (`[?a..?z, ?0..?9]`) or underscores (`?_`).
  """
  defmacro lowercase_alphanums_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?a..?z, ?0..?9, ?_], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII lowercase alphanums (`[?a..?z, ?0..?9]`) or underscores (`?_`).
  """
  defmacro lowercase_alphanums1_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?a..?z, ?0..?9, ?_], 1)
    end
  end
  

  @doc """
  Recognizes an ASCII uppercase alphanum (`[?A..?Z, ?0..?9]`).
  """
  defmacro uppercase_alphanum(ast_context) do
    quote do
      M.char(unquote(ast_context), [?A..?Z, ?0..?9])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII uppercase alphanums (`[?A..?Z, ?0..?9]`).
  """
  defmacro uppercase_alphanums(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?A..?Z, ?0..?9], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII uppercase alphanums (`[?A..?Z, ?0..?9]`).
  """
  defmacro uppercase_alphanums1(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?A..?Z, ?0..?9], 1)
    end
  end

  
  @doc """
  Recognizes an ASCII uppercase alphanums (`[?A..?Z, ?0..?9]`) or an underscore (`?_`).
  """
  defmacro uppercase_alphanum_(ast_context) do
    quote do
      M.char(unquote(ast_context), [?A..?Z, ?0..?9, ?_])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII uppercase alphanums (`[?A..?Z, ?0..?9]`) or underscores (`?_`).
  """
  defmacro uppercase_alphanums_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?A..?Z, ?0..?9, ?_], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII uppercase alphanums (`[?A..?Z, ?0..?9]`) or underscores (`?_`).
  """
  defmacro uppercase_alphanums1_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?A..?Z, ?0..?9, ?_], 1)
    end
  end
  

  @doc """
  Recognizes an ASCII lowercase word char (`[?a..?z, ?0..?9, ?_]`).
  """
  defmacro lowercase_word_char(ast_context) do
    quote do
      M.char(unquote(ast_context), [?a..?z, ?0..?9, ?_])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII lowercase word chars (`[?a..?z, ?0..?9, ?_]`).
  """
  defmacro lowercase_word_chars(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?a..?z, ?0..?9, ?_], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII lowercase word chars (`[?a..?z, ?0..?9, ?_]`).
  """
  defmacro lowercase_word_chars1(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?a..?z, ?0..?9, ?_], 1)
    end
  end

  
  @doc """
  Recognizes an ASCII lowercase word chars (`[?a..?z, ?0..?9, ?_]`) or an underscore (`?_`).
  """
  defmacro lowercase_word_char_(ast_context) do
    quote do
      M.char(unquote(ast_context), [?a..?z, ?0..?9, ?_, ?_])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII lowercase word chars (`[?a..?z, ?0..?9, ?_]`) or underscores (`?_`).
  """
  defmacro lowercase_word_chars_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?a..?z, ?0..?9, ?_, ?_], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII lowercase word chars (`[?a..?z, ?0..?9, ?_]`) or underscores (`?_`).
  """
  defmacro lowercase_word_chars1_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?a..?z, ?0..?9, ?_, ?_], 1)
    end
  end
  

  @doc """
  Recognizes an ASCII uppercase word char (`[?A..?Z, ?0..?9, ?_]`).
  """
  defmacro uppercase_word_char(ast_context) do
    quote do
      M.char(unquote(ast_context), [?A..?Z, ?0..?9, ?_])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII uppercase word chars (`[?A..?Z, ?0..?9, ?_]`).
  """
  defmacro uppercase_word_chars(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?A..?Z, ?0..?9, ?_], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII uppercase word chars (`[?A..?Z, ?0..?9, ?_]`).
  """
  defmacro uppercase_word_chars1(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?A..?Z, ?0..?9, ?_], 1)
    end
  end

  
  @doc """
  Recognizes an ASCII uppercase word chars (`[?A..?Z, ?0..?9, ?_]`) or an underscore (`?_`).
  """
  defmacro uppercase_word_char_(ast_context) do
    quote do
      M.char(unquote(ast_context), [?A..?Z, ?0..?9, ?_, ?_])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII uppercase word chars (`[?A..?Z, ?0..?9, ?_]`) or underscores (`?_`).
  """
  defmacro uppercase_word_chars_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?A..?Z, ?0..?9, ?_, ?_], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII uppercase word chars (`[?A..?Z, ?0..?9, ?_]`) or underscores (`?_`).
  """
  defmacro uppercase_word_chars1_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?A..?Z, ?0..?9, ?_, ?_], 1)
    end
  end
  

  @doc """
  Recognizes an ASCII digit (`[?0..?9]`).
  """
  defmacro digit(ast_context) do
    quote do
      M.char(unquote(ast_context), [?0..?9])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII digits (`[?0..?9]`).
  """
  defmacro digits(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?0..?9], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII digits (`[?0..?9]`).
  """
  defmacro digits1(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?0..?9], 1)
    end
  end

  
  @doc """
  Recognizes an ASCII digits (`[?0..?9]`) or an underscore (`?_`).
  """
  defmacro digit_(ast_context) do
    quote do
      M.char(unquote(ast_context), [?0..?9, ?_])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII digits (`[?0..?9]`) or underscores (`?_`).
  """
  defmacro digits_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?0..?9, ?_], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII digits (`[?0..?9]`) or underscores (`?_`).
  """
  defmacro digits1_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?0..?9, ?_], 1)
    end
  end
  

  @doc """
  Recognizes an ASCII hex digit (`[?0..?9, ?a..?f, ?A..?F]`).
  """
  defmacro hex_digit(ast_context) do
    quote do
      M.char(unquote(ast_context), [?0..?9, ?a..?f, ?A..?F])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII hex digits (`[?0..?9, ?a..?f, ?A..?F]`).
  """
  defmacro hex_digits(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?0..?9, ?a..?f, ?A..?F], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII hex digits (`[?0..?9, ?a..?f, ?A..?F]`).
  """
  defmacro hex_digits1(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?0..?9, ?a..?f, ?A..?F], 1)
    end
  end

  
  @doc """
  Recognizes an ASCII hex digits (`[?0..?9, ?a..?f, ?A..?F]`) or an underscore (`?_`).
  """
  defmacro hex_digit_(ast_context) do
    quote do
      M.char(unquote(ast_context), [?0..?9, ?a..?f, ?A..?F, ?_])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII hex digits (`[?0..?9, ?a..?f, ?A..?F]`) or underscores (`?_`).
  """
  defmacro hex_digits_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?0..?9, ?a..?f, ?A..?F, ?_], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII hex digits (`[?0..?9, ?a..?f, ?A..?F]`) or underscores (`?_`).
  """
  defmacro hex_digits1_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?0..?9, ?a..?f, ?A..?F, ?_], 1)
    end
  end
  

  @doc """
  Recognizes an ASCII lowercase hex digit (`[?0..?9, ?a..?f]`).
  """
  defmacro lowercase_hex_digit(ast_context) do
    quote do
      M.char(unquote(ast_context), [?0..?9, ?a..?f])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII lowercase hex digits (`[?0..?9, ?a..?f]`).
  """
  defmacro lowercase_hex_digits(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?0..?9, ?a..?f], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII lowercase hex digits (`[?0..?9, ?a..?f]`).
  """
  defmacro lowercase_hex_digits1(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?0..?9, ?a..?f], 1)
    end
  end

  
  @doc """
  Recognizes an ASCII lowercase hex digits (`[?0..?9, ?a..?f]`) or an underscore (`?_`).
  """
  defmacro lowercase_hex_digit_(ast_context) do
    quote do
      M.char(unquote(ast_context), [?0..?9, ?a..?f, ?_])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII lowercase hex digits (`[?0..?9, ?a..?f]`) or underscores (`?_`).
  """
  defmacro lowercase_hex_digits_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?0..?9, ?a..?f, ?_], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII lowercase hex digits (`[?0..?9, ?a..?f]`) or underscores (`?_`).
  """
  defmacro lowercase_hex_digits1_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?0..?9, ?a..?f, ?_], 1)
    end
  end
  

  @doc """
  Recognizes an ASCII uppercase hex digit (`[?0..?9, ?a..?f]`).
  """
  defmacro uppercase_hex_digit(ast_context) do
    quote do
      M.char(unquote(ast_context), [?0..?9, ?a..?f])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII uppercase hex digits (`[?0..?9, ?a..?f]`).
  """
  defmacro uppercase_hex_digits(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?0..?9, ?a..?f], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII uppercase hex digits (`[?0..?9, ?a..?f]`).
  """
  defmacro uppercase_hex_digits1(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?0..?9, ?a..?f], 1)
    end
  end

  
  @doc """
  Recognizes an ASCII uppercase hex digits (`[?0..?9, ?a..?f]`) or an underscore (`?_`).
  """
  defmacro uppercase_hex_digit_(ast_context) do
    quote do
      M.char(unquote(ast_context), [?0..?9, ?a..?f, ?_])
    end
  end
  
  @doc """
  Recognizes zero or more ASCII uppercase hex digits (`[?0..?9, ?a..?f]`) or underscores (`?_`).
  """
  defmacro uppercase_hex_digits_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?0..?9, ?a..?f, ?_], 0)
    end
  end

  @doc """
  Recognizes one or more ASCII uppercase hex digits (`[?0..?9, ?a..?f]`) or underscores (`?_`).
  """
  defmacro uppercase_hex_digits1_(ast_context) do
    quote do
      M.chars(unquote(ast_context), [?0..?9, ?a..?f, ?_], 1)
    end
  end
  

end
