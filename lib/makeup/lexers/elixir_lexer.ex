defmodule Makeup.Lexers.ElixirLexer do
  @moduledoc """
  Documentation for the Elixir lexer.
  """

  use ExSpirit.Parser, text: true

  import Makeup.Lexer.Common
  # This is required due to some speed optimizations in ExSpirit
  require Makeup.Lexer.Common.Macros

  require Makeup.Token.TokenTypes
  alias Makeup.Token.TokenTypes, as: Tok

  import Makeup.Lexer.Common.ASCII, only: [
    space: 1, spaces1: 1, digits1: 1,
    hex_digits1: 1, lowercase_letter_: 1,
    alphanums_: 1, alphanum_: 1]
  
  # # Actual lexer

  # ## Sigils

  defrule embed(
    alt([
      # Deprecated form of hexadecimal characters
      token(
        seq([
          lit("\\x"),
          alt([
            # Long form: `\x{H*}` (*deprecated*)
            seq([
              char(?{),
              chars([?0..?9, ?a..?f, ?A..?F]),
              char(?})
            ]),
            # Short form: `\xHH`
            chars([?0..?9, ?a..?f, ?A..?F], 2)
          ])
        ]),
        Tok.string_escape
      ),
      # Unicode code points `\xHHHH`
      token(
        seq([
          lit("\\u"),
          chars([?0..?9, ?a..?f, ?A..?F], 4)
        ]),
        Tok.string_escape
      ),
      # Normal escape character
      token(
        seq([char(?\\), char()]),
        Tok.string_escape
      )
    ])
  )

  defrule interpol(
    seq([
      tag(:open,
        token(lit("\#{"), Tok.string_interpol)),
      tag(:middle,
        repeat(
          lookahead_not(lit("}")) |> root_element())),
      tag(:close,
        token(lit("}"), Tok.string_interpol))
    ])
  ), pipe_result_into: process_delimiter_groups

  defrule embed_interpol(
    alt([
      embed,
      interpol
    ])
  )

  defrule sigil_no_interpol(
    seq([
      tag(:open,
        lexeme(
          seq([
            char(?~),
            char(?A..?Z)
          ])
        )
      ),
      
      tag(:middle,
        alt([
          # Heredocs must come first.
          # Otherwise, the `"..."` will ensure that `"""..."""` never matches.
          # The same applies to `'...'` vs `'''...'''`
          #
          # Heredoc sigils - double quotes
          string_like("\"\"\"", embed, "\"\"\""),
          # Heredoc sigils - single quotes
          string_like("'''", embed, "'''"),
          # Other sigils can come afterwards
          string_like("{", embed, "}"),
          string_like("[", embed, "]"),
          string_like("(", embed, ")"),
          string_like("<", embed,  ">"),
          string_like("/", embed,  "/"),
          string_like("|", embed,  "|"),
          string_like("'", embed,  "'"),
          string_like("\"", embed,  "\"")
        ])
      ),

      # Making this up because I can't find anything in the syntax reference.
      # These characters are the ones that seem to work.
      tag(:close,
        lexeme(
          chars([?a..?z, ?A..?Z], 0)
        )
      )
    ])
  ), pipe_result_into: sigil_to_tokens

  defp sigil_to_tokens([open: open, middle: parsed, close: modifiers])
    when open == "~R" or open == "~r" do
    
    [as_token(open, Tok.string_regex),
     string_like_to_tokens(parsed, Tok.string_regex),
     as_token(modifiers, Tok.string_regex)]
  end
  
  defp sigil_to_tokens([open: open, middle: parsed, close: modifiers])
    when open == "~S" or open == "~s" do

    [as_token(open, Tok.string),
     string_like_to_tokens(parsed, Tok.string),
     as_token(modifiers, Tok.string)]
  end

  defp sigil_to_tokens([open: other, middle: parsed, close: modifiers]) do
    [as_token(other, Tok.string_sigil),
    string_like_to_tokens(parsed, Tok.string_sigil),
    as_token(modifiers, Tok.string_sigil)]
  end

  defrule sigil_interpol(
    seq([
      tag(:open,
        lexeme(
          seq([
            char(?~),
            char(?a..?z)
          ])
        )
      ),
      
      tag(:middle,
        alt([
          # Heredocs must come first.
          # Otherwise, the `"..."` will ensure that `"""..."""` never matches.
          # The same applies to `'...'` vs `'''...'''`
          #
          # Heredoc sigils - double quotes
          string_like("\"\"\"", embed_interpol, "\"\"\""),
          # Heredoc sigils - single quotes
          string_like("'''", embed_interpol, "'''"),
          # Other sigils can come afterwards
          string_like("{", embed_interpol, "}"),
          string_like("[", embed_interpol, "]"),
          string_like("(", embed_interpol, ")"),
          string_like("<", embed_interpol, ">"),
          string_like("/", embed_interpol, "/"),
          string_like("|", embed_interpol, "|"),
          string_like("'", embed_interpol, "'"),
          string_like("\"", embed_interpol, "\"")
        ])
      ),

      # Making this up because I can't find anything in the syntax reference.
      # These characters are the ones that seem to work.
      tag(:close,
        lexeme(
          chars([?a..?z, ?A..?Z], 0)
        )
      )
    ])
  ), pipe_result_into: sigil_to_tokens



  # Heredocs

  defrule heredoc_double(
    string_like("\"\"\"", embed_interpol, "\"\"\"")
  ), pipe_result_into: string_like_to_tokens(Tok.string_double)

  defrule heredoc_single(
    string_like("'''", embed_interpol, "'''")
  ), pipe_result_into: string_like_to_tokens(Tok.string_single)

  # Strings and Character Lists

  defrule string(
    string_like("\"", embed_interpol, "\"")
  ), pipe_result_into: string_like_to_tokens(Tok.string_double)

  defrule charlist(
    string_like("'", embed_interpol, "'")
  ), pipe_result_into: string_like_to_tokens(Tok.string_single)


  # Elixir Operators and Tok.punctuation
  #
  # These rules use the convenient `words` macro to save some typing.
  # They should use a prefix tree, but it's probably not worth it.

  defrule operator_name(
    words(~W(
      <<< >>> ||| &&& ^^^ ~~~ === !== ~>> <~> |~> <|>
      == != <= >= && || \\ <> ++ -- |> =~ -> <- ~> <~
      = < > + - * / | . ^ & !
    ))
  )

  defrule operator(
    token(operator_name, Tok.operator)
  )

  defrule punctuation(
    token(
      words(~W{ \\\\ << >> => ( ) : ; , [ ] . % }),
      Tok.punctuation)
  )

  # ## Numbers

  # Binary numbers
  defrule number_bin(
    token(
      seq([
        lit("0b"),
        repeat(char(?0..?1), 1)]),
      Tok.number_bin)
  )

  # Octal numbers
  defrule number_oct(
    token(
      seq([
        lit("0o"),
        repeat(char(?0..?7), 1)]),
      Tok.number_oct)
  )

  # Hexadecimal numbers
  defrule number_hex(
    token(
      seq([
        lit("0x"),
        hex_digits1()]),
      Tok.number_hex)
  )

  # Normal base 10 integers

  defrule integer_part(
    seq([
      digits1(),
      repeat(
        seq([
          char(?_),
          digits1()
        ])
      )
    ])
  )

  defrule number_integer(
    token(integer_part, Tok.number_integer)
  )

  # Floating point numbers
  defrule float(
    # TODO: make it more strict.
    # Currently, this accepts things the elixir compiler doesn't
    token(
      seq([
        # Integer part (same as an integer)
        integer_part(),
        # Decimal point
        char(?.),
        # Fractional part (same as an integer)
        integer_part(),
        # (Optional) scientific notation
        repeat(
          seq([
            char([?e, ?E]),
            # Optional minus sign
            chars(?-, 0, 1),
            # Exponent
            integer_part()
          ]), 0, 1)]),
      Tok.number_float)
  )

  # ## Names

  defrule module_name_part(
    seq([
      char(?A..?Z),
      chars([?a..?z, ?A..?Z, ?_, ?0..?9], 0),
      repeat(char([??, ?!]), 0, 1)
    ])
  )

  defrule module_name(
    token(
      seq([
        module_name_part(),
        repeat(
          seq([
            char(?.),
            module_name_part()]))]),
      Tok.name_class)
  )

  defrule anon_function_arguments(
    token(
      seq([
        char(?&),
        chars(?0..?9)
      ]),
      Tok.name_entity)
  )

  defrule long_hex_char(
    token(
      seq([
        lit("?"),
        lit("\\x{"),
        hex_digits1(),
        lit("}")]),
      Tok.string_char)
  )

  defrule hex_char(
    token(
      seq([
        lit("?"),
        lit("\\x"),
        chars([?0..?9, ?a..?f, ?A..?F], 1, 2)]),
      Tok.string_char)
  )

  defrule normal_char(
    token(
      seq([
        char(??),
        char()
      ]),
      Tok.string_char
    )
  )

  defrule escape_char(
    token(
      seq([
        lit("?\\"),
        char()]),
      Tok.string_char)
  )

  defrule triple_colon(
    token(lit(":::"), Tok.operator)
  )

  defrule double_colon(
    token(lit("::"), Tok.operator)
  )

  # special_atom_re = r'(?:\.\.\.|<<>>|%\{\}|%|\{\})'
  defrule special_atom_name(
    alt([
      lit("..."),
      lit("<<>>"),
      lit("%{}"),
      lit("%{"),
      lit("%"),
      lit("{}")])
  )

  defrule special_atom(
    token(
      seq([
        char(?:),
        special_atom_name
      ]),
      Tok.string_symbol
    )
  )

  defrule normal_atom(
    token(
      seq([
        char(?:),
        alt([
          operator_name(),
          name_part()
        ])
      ]),
      Tok.string_symbol)
  )

  defrule complex_atom(
    seq([
      token(char(?:), Tok.string_symbol),
      tag(:string,
        alt([
          string_like("'", embed_interpol,  "'"),
          string_like("\"", embed_interpol,  "\"")
        ])
      )
    ])
  ), pipe_result_into: complex_atom_to_toks

  defp complex_atom_to_toks([start, string: string]) do
    [start, string_like_to_tokens(string, Tok.string_symbol)]
  end

  defrule name_part(
    seq([
      lowercase_letter_(),
      alphanums_(),
      #char([?a..?z, ?_]),
      #word_chars(),
      repeat(char([??, ?!]), 0, 1)
    ])
  )

  defrule name(
    token(name_part(), Tok.name)
  )

  defrule attribute(
    token(
      seq([
        char(?@),
        name_part()]),
      Tok.name_attribute)
  )

  defrule complex_name(
    alt([name, module_name, operator])
  )

  defrule keyword(
    seq([
      token(
        alt([
          special_atom_name(),
          complex_name()]),
        Tok.string_symbol),
      token(
        char(?:) |> lookahead(space()),
        Tok.punctuation)
    ])
  )

  defrule inline_comment(
    token(
      seq([
        char(?#),
        repeat(
          lookahead_not(char(?\n))
          |> lookahead_not(eoi())
          |> char()),
        alt([
          eoi(),
          char(?\n)])]),
      Tok.comment_single)
  )

  # iex(1)>
  # iex>
  defrule iex_prompt(
    token(
      seq([
        alt([
          lit("iex"),
          lit("...")
        ]),
        repeat(
          seq([
            lit("("),
            digits1(),
            lit(")")
          ]), 0, 1),
        lit(">")]),
      Tok.generic_prompt)
  )

  # Matching delimiters
  # - parenthesis - ()
  # - tuple: {}
  # - straight brackets - []
  # - binaries - <<>>
  # - map - %{}
  # - struct %Module{}
  
  defp process_delimiter_groups([open: open, middle: middle, close: close]) do
    # Generate unique value
    uid = unique_value()
    processed =
      # Mark the opening tag as belonging to the group `uid`
      (open |>  List.wrap |> List.flatten |> as_group(uid)) ++
      # No need to anything to the middle part
      middle ++
      # Mark the closing tag as belonging to the group `uid`
      (close |> List.wrap |> List.flatten |> as_group(uid))
    processed
  end

  defrule tuple(
    seq([
      tag(:open,
        token(lit(?{), Tok.punctuation)
      ),
      tag(:middle,
        repeat(lookahead_not(lit(?})) |> root_element())
      ),
      tag(:close,
        token(lit(?}), Tok.punctuation)
      )
    ])
  ), pipe_result_into: process_delimiter_groups

  
  defrule struct_(
    seq([
      tag(:open,
        seq([
          token(char(?%), Tok.punctuation),
          module_name(),
          token(char(?{), Tok.punctuation)])),
      tag(:middle,
        repeat(lookahead_not(char(?})) |> root_element())),
      tag(:close,
        token(char(?}), Tok.punctuation))
    ])
  ), pipe_result_into: process_delimiter_groups

  
  defrule map(
    seq([
      tag(:open,
        token(lit("%{"), Tok.punctuation)),
      tag(:middle,
        repeat(lookahead_not(char(?})) |> root_element())),
      tag(:close,
        token(char(?}), Tok.punctuation))])
  ), pipe_result_into: process_delimiter_groups

  
  defrule parens(
    seq([
      tag(:open,
        token(char(?(), Tok.punctuation)),
      tag(:middle,
        repeat(
          lookahead_not(lit(?))) |> root_element())),
      tag(:close,
        token(char(?)), Tok.punctuation))])
  ), pipe_result_into: process_delimiter_groups

  
  defrule list(
    seq([
      tag(:open,
        token(lit(?[), Tok.punctuation)),
      tag(:middle,
        repeat(lookahead_not(lit(?])) |> root_element())),
      tag(:close,
        token(lit(?]), Tok.punctuation))])
  ), pipe_result_into: process_delimiter_groups
  

  defrule binary(
    seq([
      tag(:open,
        token(lit("<<"), Tok.punctuation)),
      tag(:middle,
        repeat(lookahead_not(lit(">>")) |> root_element())),
      tag(:close,
        token(lit(">>"), Tok.punctuation))])
  ), pipe_result_into: process_delimiter_groups    


  defrule block_keyword(
    seq([
      alt([
        lit("else"),
        lit("catch"),
        lit("rescue"),
        lit("after"),
        lit("end")
      ]),
      lookahead_not(alphanum_())
    ])
  )

  defrule block_keyword_middle(
    seq([
      alt([
        lit("else"),
        lit("catch"),
        lit("rescue"),
        lit("after")
      ]),
      lookahead_not(alphanum_())
    ])
  )

  defrule end_keyword(
    lit("end") |> lookahead_not(alphanum_())
  )

  defrule do_block(
    seq([
      tag(:keyword,
        token(lit("do") |> lookahead_not(alphanum_()), Tok.name)),
      tag(:normal,
        repeat(
          lookahead_not(block_keyword())
          |> root_element(), 1)),
      repeat(
        seq([
          tag(:keyword,
            token(block_keyword_middle(), Tok.name)),
          tag(:normal,
            repeat(
              lookahead_not(block_keyword())
              |> root_element(), 1))
        ])),
      tag(:keyword,
        token(end_keyword(), Tok.name))
    ])
  ), pipe_result_into: process_do_block
        
  defp process_do_block(results) do
    uid = unique_value()
    results |> List.flatten |> Enum.map(&tag_do_block_element(&1, uid))
  end

  defp tag_do_block_element({:keyword, keyword}, uid), do: as_group(keyword, uid)
  defp tag_do_block_element({:normal, toks}, _), do: toks


  defrule fn_end(
    seq([
      tag(:open,
        token(lit("fn") |> lookahead_not(alphanum_()), Tok.name)),
      tag(:middle,
        repeat(
          lookahead_not(end_keyword())
          |> root_element(),
        1)),
      tag(:close,
        token(end_keyword(), Tok.name))
    ])
  ), pipe_result_into: process_delimiter_groups



  defrule any_char(
    token(char(), Tok.error)
  )

  defrule whitespace(
    token(spaces1(), Tok.whitespace)
  )

  defrule root_element(
    alt([
      # Whitespaces
      whitespace(),
      # Comment
      inline_comment(),
      # iex prompt
      iex_prompt(),
      # Chars
      long_hex_char(),
      hex_char(),
      escape_char(),
      normal_char(),
      # Some operators (must come before the atoms)
      triple_colon(),
      double_colon(),
      # Atoms
      special_atom(),
      complex_atom(),
      normal_atom(),
      # missing: atoms with single or double quotes
      # Module attributes
      attribute(),
      # Keywords syntax sugar (must come before names)
      keyword(),
      # Do block (must come before names)
      do_block(),
      # fn ... end (must also come before names)
      fn_end(),
      # Name
      name(),
      # Module
      module_name(),
      # Anonymous function arguments (must come before the operators)
      anon_function_arguments(),
      # Maps, tuples and structs must be matched before punctuation and operators
      struct_(),
      map(),
      tuple(),
      parens(),
      list(),
      binary(),
      # Operators
      operator(),
      # Punctuation
      punctuation(),
      # Numbers
      number_bin(),
      number_oct(),
      number_hex(),
      # Floats must come before integers
      float(),
      number_integer(),
      # Sigils (regexs are a special case of sigils)
      sigil_no_interpol(),
      sigil_interpol(),
      # Heredocs must come before strings
      heredoc_double(),
      heredoc_single(),
      # Strings and charlists (must come after the heredocs)
      string(),
      charlist(),
      any_char()
    ])
  )

  @keywords MapSet.new(~W[fn do end after else rescue catch with])

  @keyword_operators MapSet.new(~W[not and or when in])

  @builtin MapSet.new(~W[
    case cond for if unless try receive raise
    quote unquote unquote_splicing throw super])

  @builtin_declaration MapSet.new(~W[
    def defp defmodule defprotocol defmacro defmacrop
    defdelegate defexception defstruct defimpl defcallback])

  @builtin_namespace MapSet.new(~W[import require use alias])

  @constant MapSet.new(~W[nil true false])

  @pseudovar MapSet.new(~W[_ __MODULE__ __DIR__ __ENV__ __CALLER__])

  defp postprocess({:name, meta, value}) do
    name = cond do
      MapSet.member?(@keywords, value) -> Tok.keyword
      MapSet.member?(@keyword_operators, value) -> Tok.operator_word
      MapSet.member?(@builtin, value) -> Tok.keyword
      MapSet.member?(@builtin_declaration, value) -> Tok.keyword_declaration
      MapSet.member?(@builtin_namespace, value) -> Tok.keyword_namespace
      MapSet.member?(@constant, value) -> Tok.name_constant
      MapSet.member?(@pseudovar, value) -> Tok.name_builtin_pseudo
      true -> :name
    end
    {name, meta, value}
  end
  defp postprocess(token), do: token

  # The root rule for outer grammar
  defrule root(
    repeat(root_element())
  # Turn the list of list into a flat list of `{text, tag}` pairs.
  ), pipe_result_into: List.flatten

  def lex(source, merge \\ true) do
    raw = parse(source, root).result
    maybe_merged = case merge do
      false -> raw
      true -> Makeup.Lexer.merge(raw)
    end
    Enum.map(maybe_merged, &postprocess/1)
  end

end