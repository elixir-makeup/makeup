defmodule Makeup.Lexer.Common do
# ## Helper Macros (to be moved somewhere else)

  require Makeup.Lexer.Common.Macros
  alias Makeup.Lexer.Common.Macros, as: M

  defp words_expand(context, word_list) do
    {list, _} = Code.eval_quoted(word_list)
    lit_list = Enum.map(list, fn word ->
      quote do
        M.lit(
          unquote(word))
      end
    end)
    
    quote do
      unquote(context)
      |> M.lexeme(
          M.alt(
            unquote(lit_list)))
    end
  end

  defmacro words(context_ast, word_list) do
    words_expand(context_ast, word_list)
  end


  @doc """
  Write some kickass docs!
  """
  defmacro string_like(context_ast, left, middle, right) do
    quote do
      M.seq(unquote(context_ast), [
        tag(:open, M.lexeme(M.lit(unquote(left)))),
        tag(:middle,
          M.repeat(
            M.lookahead_not(M.lit(unquote(right)))
            |> M.alt([              
                # Try to parse an ininterrupted sequence of characters
                tag(:characters,
                  lexeme(
                    repeat(
                      M.lookahead_not(
                        alt([
                          M.lit(unquote(right)),
                          unquote(middle)
                        ]))
                      |> M.char(), 1)
                  )
                ),
                # Found something we want to treat diferently
                tag(:embed,
                  unquote(middle)
                ),
              ])
          )
        ),
        tag(:close, M.lexeme(M.lit(unquote(right))))
      ])
    end
  end

  defp middle_element_to_token({:embed, tokens}, _), do: tokens
  defp middle_element_to_token({:characters, binary}, tag), do: as_token(binary, tag)

  defp middle_to_tokens(middle, tag),
    do: Enum.map(middle, &middle_element_to_token(&1, tag))

  def string_like_to_tokens([open: open, middle: middle, close: close], token_tag) do
    [as_token(open, token_tag),
     middle_to_tokens(middle, token_tag),
     as_token(close, token_tag)]
  end

  @doc """
  Write some kickass docs!
  """
  defmacro string_like(context_ast, left, right) do
    quote do
      M.seq(unquote(context_ast), [
        M.lit(unquote(left)),
        M.repeat(
          M.lookahead_not(M.lit(unquote(right)))
          |> M.alt([
               M.seq([
                 char(?\\),
                 char()
               ]),
               M.char()
             ])),
        M.lit(unquote(right))]
      )
    end
  end

  defmacro interpol(context_ast, left, inner, right, repeat) do
    # How many times must we repeat the inner parser?
    {repeat_min, repeat_max} = case repeat do
      nil -> {0, -1}
      {:at_least, minimum} -> {minimum, -1}
      {:at_most, maximum} -> {0, maximum}
      {:between, {minimum, maximum}} -> {minimum, maximum}
    end
    # We will always return a list of `inner`s.
    # The only difference are how may `inner`s there are.
    quote do
      M.seq(unquote(context_ast), [
        # Get the literal match of the interpolation start sequence
        M.lexeme(M.lit(unquote(left))),
        # Get a list of things matching the `inner` parser
        M.repeat(
          M.lookahead_not(M.lit(unquote(right))) |> unquote(inner),
          unquote(repeat_min),
          unquote(repeat_max)),
        # Get the literal match of the interpolation finish sequence
        M.lexeme(M.lit(unquote(right)))
      ])
    end
  end

  @doc """
  Write some kickass docs here
  """
  defmacro string_like_with_interpolation(
      context_ast,
      left, right,
      interpol_left, interpol_inner, interpol_right,
      options \\ []) do
    # *Bewhare those who enter, for here lies dark magic!*
    #
    # In an act of extreme cultural insensitivity, the names of the arguments for this macro
    # assume a right-to-left writing system.
    # The reason for this is that I can's use `end` as a variable name, so they can't be
    # `begin` and `end` instead of `left` and `right`.
    #
    # This is obviously unexcusable and may be changed to use a more universal terminology.
    #
    # First, some words to explain the implementation.
    #
    # The intuitive way of doing this is to stop at each character, and test whether or not
    # we've reached the start of an interpolation.
    #
    # This is certainly a possibility, but it will give us a pretty unballanced parse tree:
    # we will get lot's of individual characters and a few interpolated segments.
    # Then, to make sense of the result we would have to merge those sequences of characters
    # into binaries, so that we can tag them with a token for syntax highlighting.
    #
    # We *could* merge the sequences of characters as a post-processing step, but it doesn't
    # make much sense to do so. After all, we would be collecting characters to group in a
    # collection, while leaving the interpolation segments intact.
    #
    # Worse, when we're matching the individual characters, we will take escape sequences into account,
    # so actually the sequences of individual characters will contain pairs of characters
    # (the escaped character + the escaped character).
    # This is not that trivial to do in a post-processor function.
    # Such function would have to iterate (reduce?) over the individual elements of the collection,
    # whether they are interpolations, characters or pairs of characters, and collect the appropriate
    # elements into binaries.
    #
    # If this looks a lot like parsing, it's because it is.
    # This is the job of a parser, not a post-processor, so we'll handle it here.
    # `ExSpirit` already comes with a ready-to-use tool precisely to turn complex matches
    # into flat binaries: the `lexeme` parser.
    # This is the tool we will use to gather the characters into a binary.
    
    # Extract the optional arguments from the `options` 
    escape = Keyword.get(options, :escape, "\\")
    interpol_repeat = Keyword.get(options, :repeat, nil)
    
    quote do
      M.seq(unquote(context_ast), [
        # Match the left delimiter of the string object, and return the matched text
        M.lexeme(M.lit(unquote(left))),
        # Now, let's get to the meat of the parser.
        M.repeat(
          # First, test if the string has ended
          M.lookahead_not(M.lit(unquote(right)))
          # The string hasn't ended. There are two options:
          #
          # * We have reached the start of an interpolation
          # * We have a range of normal characters in fron of us
          |> M.alt([
              # Try to parse an interpolation. To do this, we defer to the
              # `interpol` helper macro, which does the work for us.
              # There is no way to escape the interpolation.
              # Tag the interpolation to help with post processing
              M.tag(:interpol, interpol(unquote(interpol_left),
                                        unquote(interpol_inner),
                                        unquote(interpol_right),
                                        unquote(interpol_repeat))),
              # We couldn't parse an interpolation.
              # We have ahead of us a list of normal characters (possibly escaped).
              # We will collect the whole list into a flat binary.
              # 
              # Also, we the binary to distinguish it from interpolations.
              # Things get more complex here, because we need to handle more cases.
              M.tag(:normal,
                # Use the lexeme parser to turn the result into a flat binary, as discussed above.
                M.lexeme(
                  # We'll try to match a sequence of either single characters
                  # or the escape sequence followed by a normal character. 
                  repeat(
                    # Make sure we didn't reach the end of the string
                    M.lookahead_not(M.lit(unquote(right)))
                    # Make sure we didn't reach the start of an interpolation
                    |> M.lookahead_not(M.lit(unquote(interpol_left)))
                    # Now we must distinguish the two alternatives we've discussed:
                    |> M.alt([
                        # An escape sequence followed by a character
                        M.seq([
                          M.lit(unquote(escape)),
                          M.char()
                        ]),
                        # A single character.
                        # This match is safe because we already know that the next
                        # character doesn't terminate the string *and* doesn't start an
                        # interpolation (see the negative lookahead above)
                        M.char()
                      ])
                  )
                )
              )
            ])
        ),
        # After the `repeat`, we have a literal binary (the match of the start delimiter),
        # followed by a list of tagged tuples:
        #
        #     [{Tok.string, ...}, {:interpol, ...}, {Tok.string, ...}, ...]
        #
        # If we have reached this far and are out of the `repeat` combinator above,
        # it's because the lookahead has found the end of the string.
        #
        # Match the end of the string (turning it into a *lexeme*) and we're done.
        M.lexeme(M.lit(unquote(right)))
      ])
      # The final format of the parse result will be:
      #
      #     ["left_lexeme", [{Tok.string, ...}, {:interpol, ...}, {Tok.string, ...}, ...], "right_lexeme"]
      #
      # This format is easy enough to manipulate manually, but we provide a convenience function wo work with it.
    end
  end

  @doc """
  Tags the result of `t:string_like_with_interpolation/7` with user-given token types.
  """
  def tag_interpol([left, inners, right], tag, interpol_tag \\ :string_interpol) do
    tagged_inners = inners
    |> Enum.map(fn
        {:normal, value} -> as_token(value, tag)
        {:interpol, [interpol_left, interpol_middle, interpol_right]} ->
          [as_token(interpol_left, interpol_tag)] ++
          interpol_middle ++
          [as_token(interpol_right, interpol_tag)]
      end)
    [as_token(left, tag)] ++ tagged_inners ++ [as_token(right, tag)]
  end

  defmacro optional(context_ast, parser) do
    quote do
      # Invoke the macro from the othe module
      M.repeat(
        # We must pass the parsing context for some reason
        unquote(context_ast),
        # The parser that will be repeated
        unquote(parser),
        # Minimum number of repetitions
        0,
        # Maximum number of repetitions
        1)
    end
  end

  @doc """
  Creates a token out of the text parsed by the parser and the user arguments.
  """
  defmacro token(context_ast, parser_ast, tag_ast) do
    quote location: :keep do
      case unquote(context_ast) |> M.lexeme(unquote(parser_ast)) do
        %{error: nil} = good_context ->
          %{good_context | result: {unquote(tag_ast), %{}, good_context.result}}
        bad_context ->
          bad_context
      end
    end
  end

  defmacro token(context_ast, parser_ast, tag_ast, meta_ast) do
    quote location: :keep do
      case unquote(context_ast) |> M.lexeme(unquote(parser_ast))  do
        %{error: nil} = good_context ->
          %{good_context |
              result: {unquote(tag_ast), unquote(meta_ast), good_context.result}}
        bad_context ->
          bad_context
      end
    end
  end

  def as_token(value, tag, meta \\ %{}) do
    {tag, meta, value}
  end

  def toks(results, tags, meta \\ %{}) when is_list(tags) and is_list(results) do
    for {tag, {_, _, value} = result} <- Enum.zip(tags, results),
        value != "",
        do: {tag, meta, result}
  end


  def unique_value, do: :erlang.unique_integer([:positive, :monotonic])

  def with_meta(results, key, value) when is_list(results) do
    for {tag, meta, val} <- results, do: {tag, Map.put(meta, key, value), val}
  end

  def with_meta({tag, meta, val}, key, value) do
    {tag, Map.put(meta, key, value), val}
  end

  def as_group(results, group_id) do
    with_meta(results, :group_id, group_id)
  end

  @doc """
  Drops empty tokens from the list.
  """
  def drop_empty(results) do
    Enum.filter(results, fn {_, _, value} -> value != "" end)
  end
end