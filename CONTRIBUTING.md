This document is meant to help people who want to contribute to Makeup.

# High Level Architecture

## What Makeup Is

The goal of Makeup is to take up something plain, and turn it into something pretty.
The previous sentence is only the first of probably many puns about makeup.

Makeup takes as argument a string representing source code,
and returns some data that contains the highlighted source code.

Currently, Makeup only supports HTML output (actually HTML + CSS + a little Javascript).
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
but in general it's probably not really worth it.

Makeup is not a tool to hyperlink your source code.
While such tools might be built on top of Makeup, it's not the original goal.

# Lexers

The *Lexer*, turns the raw source code into a flat list of tokens.

## Tokens

A token has the following type:

```elixir
{atom(), Map.t, String.t}
```

The token format was inspired by the format of the elixir AST node.

  * The *first* element of the 3-tuple is the type of token.
    Makeup supports a limited type of tokens.
    The supported token types are documented in the
    [Makeup.Token.TokenTypes](https://hexdocs.pm/makeup/Makeup.Token.TokenTypes.html) module.
    Although you can specify token types as atoms, the
    [Makeup.Token.TokenTypes](https://hexdocs.pm/makeup/Makeup.Token.TokenTypes.html) module
    defines a number of macros that expand into the correct atoms.
    Using these macros whenever possible is good practice, because it protects you
    from typos. Macro names will be checkes at compile times, unlike atoms, which
    might give rise to errors that will only be visible at runtime
    or may even remain undetected.
    In some places, like pattern matching in function heads,
    you won't be able to use the macros.
    In those cases, just use the corresponding atom.

  * The *second* element is a map, containing some metadata about the token.
    Some formatters can make use of the metadata in order to improve the output.
    The only piece of metadata currently used by the formatter is the `group_id` key.
    It's used to mark delimiters as belonging to the same group, so that they are both
    highlighted when the user places the mouse cursor on top of one of them.

  * The *third* element is the literal string containing the text that forms the token.
    The concatenation of the strings from all the tokens
    is equal to the contents fo the raw string used to generate the tokens.

For example, the following are valid tokens:

  * `{:name, %{}, "a"}` - represents the variable `a`

  * `{:string_double, %{}, "\"A String\""}` - represents a literal string

  * `{:number_integer, %{}, "17"}` - represents the number `17`

This token format was inspired by the format of the Elixir AST nodes.

## Improving an Existing Lexer

Current lexers are not necessarily written for efficiency.
There are probably lots of opportunities to profile the lexers and increase performance.
Although performance is important, being correct is the highest priority.
When faced between the choice between being fast or being correct,
we must always choose being correct.

Some concrete suggestions:

  * I the Elixir lexer, replace `alt([lit("word1"), lit("word2"), ...])`
    with the `symbols()` parser and a `ExSpirit.TreeMap`.

  * Write some utilities that make it easier to embed `ExSpirit.TreeMap`s
    inside parsers defined with `defrule`

## Writing a New Lexer

Makeup lexers use the excellent ExSpirit parsing library be default.
Writing an ExSpirit parser is not a requirement to write an Elixir lexer.
As said above, a lexer is just a module that contains a function that turns
the raw source code into a list of tokens.

You can write your lexer in any way you want.
You may use a different parsing library, a custom tokenizer, or even something like Regexs.
On the other hand, by doing so you won't be making use of the combinators defined by Makeup.
And ExSpirit is probably the best general-purpose parser available on Elixir.

Because a Lexer is just a module that exports a certain function,
there is no need for your parser to output the final token stream.
You can process the token stream any way you want, as long as the format is the same.
For example, the current Elixir lexer iterates over the identifiers
in the token list to highlight some keywords such as `if`, `when` and `defmodule`.

A new lexer should make an effort to match delimiters such as parenthesis when appropriate.
Such matched delimiters can be highlighted when the user places the mouse cursor
on top of one of the delimiters.
This makes it easy to visualize which part of the code is surrounded by the delimiters.
This is not a hard requirement for a new lexer, of course, but it's probably
quite easy to implement for almost every language.

TODO: Describe the most important parsers.

### Aside: A Parser? Why not Regexes? The're simpler...

Can't I just use a Regex-based lexer like normal people?

Well, you can if you really want to.
But Regexes are very weak, and clearly not enough to lex most programming languages.
Most Regex-based lexers (like those employed by Pygments) are actually state machines
with arbitrarily deep stacks with state transitions driven by Regex matches.
This is equivalent to a stack-based automaton, which allows these lexers
to support arbitrary levels of nesting.

This is good enough to reasonably tokenize most programming languages,
but it's much more low level than ExSpirit.
ExSpirit allows you to define possibly recursive rules
and handles the state transitions itself, probably with better performance.

It's easy to port a Pygments lexer into Elixir, and sometimes they are shorter.
The hardest part is actually to extract the rules from the Regex-driven state machine.

# Formatter

## Improving an Existing Formatter

The HTML formatter probably doesn't need many improvements.

## Writing a New Formatter

Some formatters that would be interesting to have:

  * HTLM Formatter with inline CSS styles (the default one uses CSS classes)
  * (La)TeX Formatter
  * Formatter suitable for use in terminals

While lexers will remain in separate packages for the foreseeable future,
I think formatters should be available on Makeup itself.
You can of course write your own formatters tailored to your projects.

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
It's probably not too hard to write a simple CSS parser and interpreter using ExSpirit.

# Writing Documentation

## Improving Makeup's Documentation

This document is a work in progress.
Educating people so that they can contribute (especially new lexers) is a priority.
A tool such as Makeup depends ond the work of many people, as no one is proeficient
in all the programming languages Makeup might have to highlight.

Also, at the moment, the options recognized by the lexers are not documented properly.
Currently only the Elixir lexer recognizes options.

## Improving ExSpirit's Documentation

Makeup lexers depend on ExSpirit.
The ExSpirit docs are somewhat lacking at the moment.
Teaching people how to use ExSpirit is important if we want to encourage new contributions.

# Adoption and Marketing

Increasing the adoption of Makeup is desirable, because not only it enhances
the readability of code examples in the wild, but it might bring new contributors.
New contributors bring new lexers, which bring higher adoption, which brings new contributors.
This is a virtuous cycle we must encourage.
