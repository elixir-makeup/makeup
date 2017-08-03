defmodule Makeup.Lexers.HTML5Lexer do
  @moduledoc """
  Documentation for the HTML5 lexer.

  Unlike the Pygments lexer that served as an inspiration (which uses Regexs),
  we try to make a proper job out of parsing the HTML and extract some structure.
  
  We *will* match opening and closing tags, and will make use of those tags to
  add some functionality.
  """

  use ExSpirit.Parser, text: true

  import Makeup.Lexer.Common
  # This is required due to some speed optimizations in ExSpirit
  require Makeup.Lexer.Common.Macros

  require Makeup.Token.TokenTypes
  alias Makeup.Token.TokenTypes, as: Tok

  alias Makeup.Lexer.Common.ASCII
  require ASCII
  import ASCII, only: [spaces: 1, spaces1: 1]

  # Still missing:
  # - write CSS lexer
  # - write javascript lexer


  defrule entity(
    token(
      seq([
        char([?%, ?&]),
        chars(-?;),
        char(?;)
      ]),
      Tok.name_entity
    )
  )

  # The next four rules are basically the same,
  # but with more descriptive names.
  defrule extended_tag_name(
    chars([?A..?Z, ?a..?z, ?0..?9, ?:, ?!, ?., ?-, ?/, ?%])
  )
  
  defrule extended_attribute_name(
    chars([?A..?Z, ?a..?z, ?0..?9, ?:, ?!, ?., ?-, ?/, ?%])
  )

  defrule unquoted_attribute_value(
    chars([?A..?Z, ?a..?z, ?0..?9, ?:, ?!, ?., ?-, ?/, ?%])
  )

  defrule extended_identifier(
    chars([?A..?Z, ?a..?z, ?0..?9, ?:, ?!, ?., ?-, ?/, ?%])
  )
  
  # HTML comment. HTML comments can't be nested.
  defrule comment(
    token(string_like("<!--", "-->"), Tok.comment)
  )

  defrule whitespace(
    token(spaces1(), Tok.whitespace)
  )

  defrule string_double(
    token(string_like("\"", "\""), Tok.string_double)
  )

  defrule string_single(
    token(string_like("'", "'"), Tok.string_single)
  )

  # HTML attribute. Recognizes the following formats:
  #
  # * `key` (e.g. ` <input type="text" disabled>`)
  # * `key="value"` (e.g. <script src="myscript.js"></script>)
  # * `key='value'` (e.g. <script src='myscript.js'></script>)
  # * `key=value` (e.g. `<a href=https://www.w3schools.com></a>`)
  defrule attribute(
    seq([
      # Attribute_name
      token(extended_attribute_name(), Tok.name_attribute),
      # Optionally:
      repeat(
        seq([
          token(spaces(), Tok.text),
          # Equals sign
          token(lit(?=), Tok.punctuation),
          token(spaces(), Tok.text),
          # Attribute value. Can be a string or "naked" extended identifier
          alt([
            string_double(),
            string_single(),
            token(unquoted_attribute_value(), Tok.string)
          ]),
          token(spaces(), Tok.text)
        ]), 0, 1)
    ])
  )

  # Normal text inside a tag
  defrule document_text(
    repeat(
      alt([
        entity(),
        token(chars([-?<, -?&]), Tok.text)
      ]), 1)
  )

  # Fallback for the cases where the lexer can't recognize anything else
  defrule any_char(
    token(char(), Tok.error)
  )

  # Top level nodes inside the Root of an HTML
  defrule root_node(
    alt([
      whitespace(),
      comment(),      
      xml_self_closing_tag(),
      html_tag(),
      html_self_closing_tag(),
      document_text(),
      any_char()
    ])
  )

  # The Root rule to lex an HTML document
  defrule root(
    repeat(root_node())
  ), pipe_result_into: List.flatten()

  # Self-closing XML tags: `<tag .../>`
  defrule xml_self_closing_tag(
    seq([
      token(char(?<), Tok.punctuation),
      token(spaces(), Tok.text),
      token(extended_tag_name() |> put_state(:tag_name, :result), Tok.name_tag),
      token(spaces(), Tok.text),
      repeat(
        seq([
          token(spaces1(), Tok.text),
          attribute()
        ])
      ),
      token(char(?/), Tok.punctuation),
      token(spaces(), Tok.text),
      token(char(?>), Tok.punctuation)
    ])
  ), pipe_result_into: List.flatten


  # Self-closing tags for HTML: `<img ...>`, `<link ...>`, etc.
  # Actually, we accept any tag.
  defrule html_self_closing_tag(
    seq([
      token(char(?<), Tok.punctuation),
      token(spaces(), Tok.text),
      token(extended_tag_name(), Tok.name_tag),
      repeat(
        seq([
          token(spaces1(), Tok.text),
          attribute()
        ])
      ),
      token(spaces(), Tok.text),
      token(char(?>), Tok.punctuation)
    ])
  ), pipe_result_into: List.flatten |> drop_empty

  # Recognizes matching opening and closing tags and their content:
  # `<tag ...>...</tag>` 
  #
  # It's the most complex rule in the file.
  # Its design of this rule deserves some explanation.
  # 
  # We want to treat the open and close tags differently from the content.
  # The easiest way to do it is by tagging the parse results using the `tag` macro.
  # The first three tags are:
  #
  # * `:open` - contains the opening tag and it's attributes `</tag ...>`
  # * `:middle` - contains the tag contents (child tags, text, etc.)
  # * `:close` - contains the closing tag (i.e. `</tag>`)
  #
  # These three tags are enough if all we want is to know the tokens that
  # belong to the opening and closing tags (to mark them as belonging
  # to the same group, for example).
  #
  # But we want to do something a little more advanced.
  #
  # We want to render the text according to the containing element.
  # For example, we would like the contents of the `<strong></strong>`
  # tag to render as bold text.
  # For this we need more information than what we have above.
  # We need the tag name.
  #
  # To make it easier for the postprocessor to find the tag name,
  # we will add a fourth tag (`:tag_name`) from which we can extract the tag name.
  defrule html_tag(
    seq([
      # **First** tag: the opening delimiter
      tag(
        :open,
        seq([
          token(char(?<), Tok.punctuation),
          token(spaces(), Tok.text),
          # Recognize the tag name, and put it in the state, because we'll need it later
          # to match the closing tag.
          token(extended_tag_name() |> put_state(:tag_name, :result), Tok.name_tag),
          # Match the attributes
          repeat(
            seq([
              token(spaces1(), Tok.text),
              attribute()
            ])
          ),
          token(char(?>), Tok.punctuation)
        ])
      ),
      # **Second** tag: the element contents
      tag(:middle,
        repeat(
          lookahead_not(
            seq([
              token(char(?<), Tok.punctuation),
              token(spaces(), Tok.text),
              token(char(?/), Tok.punctuation),
              token(spaces(), Tok.text),
              get_state_into(:tag_name, token(lit(&1), Tok.name_tag)),
              token(spaces(), Tok.text),
              token(char(?>), Tok.punctuation)
            ])
          ) |> root_node
        )
      ),
      # **Third* tag: the closing tag
      tag(
        :close,
        seq([
          token(char(?<), Tok.punctuation),
          token(spaces(), Tok.text),
          token(char(?/), Tok.punctuation),
          token(spaces(), Tok.text),
          # Get the tag name from the state and try to match it
          get_state_into(:tag_name, token(lit(&1), Tok.name_tag)),
          token(spaces(), Tok.text),
          token(char(?>), Tok.punctuation)
        ])
      ),
      # ** Fourth** tag: the `tag_name`.
      # Above, we have put it inside the state.
      # The easiest way to make it available fo the function we're going to pipe this into
      # is to get the state into a parser that returns a constant string.
      # This will be the `success` parser.
      tag(:tag_name, get_state_into(:tag_name, success(&1)))
    ])
     # Now we've created an ssociation list which we can desconstruct
     # and process.
  ), pipe_result_into: (fn [open: open,
                            middle: middle,
                            close: close,
                            tag_name: tag_name] ->
        # Generate a unique value.
        # This value is random, so it makes the output of the lexer non-deterministic.
        # The value will be unique for each BEAM run.
        # This degree of uniqueness is probably good enough for our purposes.
        uid = unique_value()

        new_result =
          # Mark the opening tag as belonging to the group `uid`
          (open |> List.flatten |> drop_empty |> as_group(uid)) ++
          # Apply markup to text that has no other markup.
          # Does not override the markup set by child tags.
          (middle |> List.flatten |> apply_markup_to_text(tag_name)) ++
          # Mark the closing tag as belonging to the group `uid`
          (close |> drop_empty |> as_group(uid))
        
        new_result
      end).()

  defp apply_markup_to_text(tokens, tag_name) do
    # Look up the correct markup for our tag
    case markup_for_html_tag(tag_name) do
      # If no markup is to be set, return the tokens unchanged.
      nil -> tokens
      # Otherwise, set the markup
      new_tag -> Enum.map(tokens, &(change_token_tag(&1, new_tag)))
    end
  end

  # For each HTML tag, return the markup for the child tags
  defp markup_for_html_tag("b"), do: Tok.generic_strong
  defp markup_for_html_tag("strong"), do: Tok.generic_strong
  defp markup_for_html_tag("i"), do: Tok.generic_emph
  defp markup_for_html_tag("em"), do: Tok.generic_emph
  defp markup_for_html_tag("s"), do: Tok.generic_deleted
  defp markup_for_html_tag("kbd"), do: Tok.generic_output
  defp markup_for_html_tag("h1"), do: Tok.generic_heading
  defp markup_for_html_tag("h2"), do: Tok.generic_subheading
  defp markup_for_html_tag("h3"), do: Tok.generic_subheading
  defp markup_for_html_tag("h4"), do: Tok.generic_subheading
  defp markup_for_html_tag("h5"), do: Tok.generic_subheading
  defp markup_for_html_tag("h6"), do: Tok.generic_subheading
  defp markup_for_html_tag(_), do: nil

  defp change_token_tag({old_token_tag, meta, value} = old_token, new_token_tag) do
    case old_token_tag do
      Tok.text -> {new_token_tag, meta, value}
      _ -> old_token
    end
  end


  def lex(source, merge \\ true) do
    raw = parse(source, root).result
    case merge do
      false -> raw
      true -> Makeup.Lexer.merge(raw)
    end
  end

end