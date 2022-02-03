# Contributing

This document is meant to help people who want to contribute to Makeup.

## The release script

This project uses a release script to make it easy to publish a new release.
The script performs a series of checks and executes a number of tasks.

The script was inspired by the continuous release philosophy of the Python Hypothesis library.
You can find a high-level description [here](https://hypothesis.works/articles/continuous-releases/).
There are many differences though.
The main one is that this release script acts purely locally, and must be explicitly invoked,
while the one in hypothesis is a commit hook that runs on a continuous integration server.

Currently, the script does the following:

  1. Run the tests (abort the release if any tests fail)
  2. Get the current version from the `mix.exs` file
  3. Read a special `RELEASE.md` file to extract the release type (major, minor or patch)
     and the text to add as a new entry in the CHANGELOG
  4. Update the version
  5. Add the new version to the `mix.exs` file
  6. Add a new entry to the CHANGELOG
  7. Commit the changes to Git
  8. Add a `vX.Y.Z` tag to the repo, so that it's easy to find each release
  9. Remove the `RELEASE.md` file, which must be written again for a new release
  10. Publish the package on Hex.pm

It decreases the number of mistakes and the amount of commands you need to run.

The path to the script is `scripts/release.exs`.
The `mix.exs` file defines an alias so that you can run the script `mix release`.

## Special files

### The `RELEASE.md` file

The `RELEASE.md` file must start with a line of the form `RELEASE_TYPE: type`,
where type is either `major`, `minor` or `patch`.

The following lines are used as the text for the entry in the changelog file.

A simple example of a `RELEASE.md` file would be:

    RELEASE_TYPE: minor

    This is a minor release.
    It adds a minor feature and fixes two important bugs.

### The `CHANGELOG.md` file

The `CHANGELOG.md` file must contain the following line:

    <!-- %% CHANGELOG_ENTRIES %% -->

The newest changelog entry will be under this line.

## Using

# High Level Architecture

## What Makeup Is

The goal of Makeup is to take up something plain, and turn it into something pretty.
The previous sentence is only the first of probably many puns about makeup.

Makeup takes as argument a string representing source code,
and returns some data that contains the highlighted source code.

Currently, Makeup only supports HTML output (actually HTML + CSS + a little JavaScript).
In the future it might support other kinds of output.

It's made up of three parts:

  * The *Lexer*, which turns the raw source code into a list of tokens.
    There must be a lexer per programming language.
  * The *Formatter*, which turns the list of tokens into something else
    (what exactly is format dependent).
  * The *Styles*, which control the output of the Formatter.

The main goal of having syntax highlighting is to make the code more understandable
for a *human* audience.
As discussed above, there is no need to actually parse the raw source into a valid AST.
This allows us to make lots of simplifications regarding what exactly to parse,
and which kinds of tokens we recognize.

## What Makeup Is Not

Makeup is not a static code analyzer.
As an analyzer, Makeup is very shallow and only cares about the surface details of your code.
The goal here is to make the code pretty to humans, not to gain any deep insights.

Makeup is not a general-purpose language parser.
If it helps you write a better lexer, by all means implement a parser
for the language in question so that you can lex it better,
but in general it's probably not worth it.

Makeup is not a tool to hyperlink your source code.
While such tools might be built on top of Makeup, it's not the original goal.

# Lexers

The *Lexer*, turns the raw source code into a flat list of tokens.

## Tokens

A token has the following type:

```elixir
{atom(), map(), String.t()}
```

The token format was inspired by the format of an Elixir AST node.

  * The *first* element of the 3-tuple is the type of token.
    Makeup supports a limited number of token types.
    The supported token types are: [[...]](#supported-tokens)

  * The *second* element is a map, containing some metadata about the token.
    Some formatters can make use of the metadata in order to improve the output.
    The only metadata keys currently used by the HTML formatter are the `:group_id` and the `:unselectable` keys.

    * `:group_id` is used to mark delimiters as belonging to the same group, so that they are both highlighted when the user places the mouse cursor on top of one of them.

    * `:unselectable` is used to mark a certain token as impossible to select in the HTML output.
      It's useful for prompts in interactive interpreter sessions, which you usually don't want to copy and paste.

  * The *third* element is an iolist (not exactly, see below) or a binary containing the text that forms the token.
    Makeup lexers should by default use iolists instead of binaries because they usually bring better performance.

For example, the following are valid tokens:

  * `{:name, %{}, "a"}` - represents the variable `a`

  * `{:string_double, %{}, "\"A String\""}` - represents a literal string

  * `{:number_integer, %{}, ["17"]}` - represents the number `17`

### Note: iolists and makeup

The above description of the third element of the token is a slight simplification.
Erlang iolists can contain *binaries*, *lists* and *integers representing bytes*.
They can't contain arbitrary integers that encode Unicode characters.

It's very inconvenient to handle these Unicode characters inside the lexer,
so Makeup has chosen to handle them inside the *formatter*, which actually writes the "iolists" into an output device or a string.

Because the *formatter* usually has to escape the token values anyway, it is natural to "escape" Unicode characters at that level.

## Improving an Existing Lexer

There are probably lots of opportunities to profile the lexers and increase performance.
Although performance is important, being correct is also important.
When faced with the choice between being fast or being correct, you should be aware of the trade-off.

## Writing a New Lexer

Makeup lexers use the excellent [NimbleParsec](https://github.com/plataformatec/nimble_parsec) parsing library by default.
Writing a NimbleParsec parser is not a requirement to write an Elixir lexer.
As said above, a lexer is just a module that implements the behavior above.

You can write your lexer in any way you want.
You may use a different parsing library, a custom tokenizer, or even something like Regex.
On the other hand, by doing so you won't be making use of the combinators defined by Makeup.

Because a Lexer is just a module that implements a behavior,
there is no need for your grammar rules to output the final token stream.
You can process the token stream any way you want, as long as the format is the same.
For example, the current Elixir lexer iterates over the identifiers
in the token list to highlight some keywords such as `if`, `when` and `defmodule`.

Makeup now provides an API to register lexers on application start.
This means that you can dynamically add support for new programming languages by just depending on a new lexer (as long as the application which is using Makeup knows how to get a lexer from the registry, of course).

The lexer has the responsibility to register itself on application start.

### Matching delimiters

A new lexer should make an effort to match delimiters such as parenthesis when appropriate.
Such matched delimiters can be highlighted when the user places the mouse cursor
on top of one of the delimiters.
This makes it easy to visualize which part of the code is surrounded by the delimiters.
This is not a hard requirement for a new lexer, of course, but it's probably
quite easy to implement for almost every language.

```html
<pre><code>
<b>def</b> f<span data-group-id='group-1'>(</span>x<span  data-group-id='group-1'>)</span>
<span  data-group-id='group-2'><b>do</b></span>
  x + 1
<span data-group-id='group-2'><b>end</b></span>
</code></pre>
```

### Aside: A Parser? Why not Regexes? They're simpler...

Can't I just use a Regex-based lexer like normal people?

Well, you can if you really want to.
But Regexes are very weak, and clearly not enough to lex most programming languages.

Most Regex-based lexers (like those employed by Pygments) are actually state machines
with arbitrarily deep stacks with state transitions driven by Regex matches.
This is equivalent to a stack-based automaton, which allows these lexers
to support arbitrary levels of nesting.

This is good enough to reasonably tokenize most programming languages,
but it's much more low level than NimbleParsec (and probably slower).
NimbleParsec allows you to define possibly recursive rules
and handles the state transitions itself, probably with better performance.

It's quite easy to port a Pygments lexer into Elixir, and sometimes they are shorter.
The hardest part is actually extracting the rules from the Regex-driven state machine.

# Formatter

A formatter is an arbitrary module, which exports functions that perform arbitrary transformations on your list of tokens.
The output formats are so different that it doesn't really make much sense for a formatter to implement a behavior.
Some formatters should only output iolists, while others should only output binaries.
Others might not produce any output.
Think for example of a code formatter for a GUI application, which may work only by running function calls that statefully change the UI state.

Usually you'll want to implement two functions:

  * `format_as_iolist(tokens, opts \\ [])` (converts a list of tokens into an iolist)
  * `format_as_binary(tokens, opts \\ [])` (converts a list of tokens into a binary)

### Note: why iolists?

Concatenating strings is very slow on the BEAM.
The fast way to generate strings is to first generate an iolist and then calling `IO.iodata_to_binary/1` on the iolist to generate a binary.

## Improving an Existing Formatter

The HTML formatter probably doesn't need many improvements.

## Writing a New Formatter

Some formatters that would be interesting to have:

  * HTML Formatter with inline CSS styles (the default one uses CSS classes)
  * (La)TeX Formatter
  * Formatter suitable for use in terminals

While lexers will remain in separate packages for the foreseeable future,
I think formatters could be available on Makeup itself.
You can of course write your own formatters tailored to your projects.

Be sure to use iolists instead of binaries whenever possible.

# Style

## Improving an Existing Style

While existing styles could use some improvements, you're probably better off
writing and contributing new ones.

## Writing a New Style

Writing a style is easy.
A style is just an Elixir module that can be converted into a CSS stylesheet.
If you prefer, you can write the CSS stylesheet directly for your application,
but for now, Makeup will only accept styles written as Elixir modules.

It's possible that in the future there will be a macro that generates an
Elixir module at compile-time from a CSS stylesheet.
It's probably not too hard to write a simple CSS parser and interpreter using NimbleParsec.

# Writing Documentation

## Improving Makeup's Documentation

This document is a work in progress.
Educating people so that they can contribute (especially new lexers) is a priority.
A tool such as Makeup depends on the work of many people, as no one is proficient
in all the programming languages Makeup might have to highlight.

Also, at the moment, the options recognized by the lexers are not documented properly.

## Improving NimbleParsec's Documentation

Makeup lexers depend on NimbleParsec.
The NimbleParsec docs and test suite are somewhat lacking at the moment.
Teaching people how to use NimbleParsec is important if we want to encourage new contributions.
Currently, not many people are using NimbleParsec, so building a knowledge base around it might be important.

# Adoption and Marketing

Increasing the adoption of Makeup is desirable, because not only it enhances
the readability of code examples in the wild, but it might bring new contributors.
New contributors bring new lexers, which bring higher adoption, which brings new contributors.
This is a virtuous cycle we must encourage.

---
#### Supported Tokens <a id="supported-tokens"></a>

```elixir
    :comment
    :comment_hashbang
    :comment_multiline
    :comment_preproc
    :comment_preproc_file
    :comment_single
    :comment_special
    :error
    :escape
    :generic
    :generic_deleted
    :generic_emph,
    :generic_error
    :generic_heading,
    :generic_inserted
    :generic_output,
    :generic_prompt
    :generic_strong
    :generic_subheading
    :generic_traceback
    :keyword
    :keyword_constant
    :keyword_declaration,
    :keyword_namespace
    :keyword_pseudo
    :keyword_reserved
    :keyword_type,
    :literal
    :literal_date
    :name
    :name_attribute
    :name_builtin,
    :name_builtin_pseudo
    :name_class
    :name_constant
    :name_decorator
    :name_entity
    :name_exception
    :name_function
    :name_function_magic
    :name_label
    :name_namespace
    :name_other
    :name_property
    :name_tag
    :name_variable,
    :name_variable_class,
    :name_variable_global
    :name_variable_instance
    :name_variable_magic
    :number,
    :number_bin
    :number_float,
    :number_hex
    :number_integer
    :number_integer_long
    :number_oct,
    :operator,
    :operator_word,
    :other
    :punctuation
    :string
    :string_affix
    :string_backtick,
    :string_char
    :string_delimiter,
    :string_doc
    :string_double
    :string_escape
    :string_heredoc
    :string_interpol,
    :string_other
    :string_regex
    :string_sigil
    :string_single
    :string_symbol
    :text
    :whitespace
```
