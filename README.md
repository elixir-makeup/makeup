# Makeup

## Introduction

Makeup is a "generic syntax highlighter suitable for use in code hosting, forums, wikis or other applications that need to prettify source code" . This tagline was shamelessly stolen from the [Pygments website](http://pygments.org/).

Pygments the major inspiration for this package, and the structure is basically the same.
It has **lexers**, **formatters** and **styles**.

* **Lexers** turn the source code into a list of tokens
* **Formatters** turn the list of tokens into something else (HTML, TeX, images, etc.).
  Currently only an HTML formatter exists.
* **Styles** customize the output of the formatter.
  Makeup supports all Pygments' styles (in fact, they were converted from the Python's source).
  New custom styles can be added to makeup itself, or defined in the Project that uses it.

## Demo

To see a sample of Makeup's output, go check the [demo](https://tmbb.github.io/makeup_demo/).
Please note that not all styles define all differences between tokens.
In a given style, strings and characters might be rendered in the same color while in others , the colors might be different.
That is style-dependent.
Some of the richer styles are
the Tango style ([elixir](https://tmbb.github.io/makeup_demo/elixir.html#tango)),
the Colorful style ([elixir](https://tmbb.github.io/makeup_demo/elixir.html#colorful)),
the Default style ([elixir](https://tmbb.github.io/makeup_demo/elixir.html#default)) and
the Friendly style ([elixir](https://tmbb.github.io/makeup_demo/elixir.html#friendly)).

## Supported Languages

Currently, the only supported source language is
[Elixir](https://tmbb.github.io/makeup_demo/elixir.html).

HTML5 used to be supported, but the newest version has removed it
(because the old lexer is no longer backward compatible with the new version)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `makeup` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:makeup, "~> 0.4.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/makeup](https://hexdocs.pm/makeup).

The ExDocs are still pretty primitive.

## Quickstart

To highlight some Elixir code (newlines added for clarity):

```elixir
Makeup.highlight(source)
# "<pre class=\"highlight\"><code>
#   <span class=\"n\">x</span><span class=\"w\"> </span>
#   <span class=\"o\">+</span><span class=\"w\"> </span><span class=\"mi\">1</span>
# </code></pre>\n"
```

As you can see, the default HTML formatter uses CSS classes.
You'll need a CSS stylesheet to get the different colors and styles.

To generate a stylesheet:

```
Makeup.stylesheet(style) # by default, the StyleMap.default style is used.
# ... output ommited
```

## Advantages over Pygments

One of the greatest advantages is that it runs on the BEAM, so it can be used with Elixir projects without external dependencies.

Another advantage is that the way lexers are written, we can be a lot smarter than Pygments in processing the output.

For the developer, lexers are also easier to write than the Pygments lexers, because we use a PEG parser.
Most Pygments lexers use something like a state table that works based on regex matches,
and uses the results of those matches to switch to another state.
Using a PEG parser we can define the grammar in a more natural way.

## Disadvantages over Pygments

It supports only a single language (yet, contributions are welcome!).

The lexers are written using the excellent [NimbleParsec](https://github.com/plataformatec/nimble_parsec) parser.

Older version used the ExSpirit parser, which was more flexible but slower (about 10x slower) and a little less easy to use.

## Benchmarks

TODO

## Documentation on how to write a new lexer

Contributions are highly appreciated.
The mos direct way you can contribute to Makeup is by writing a new lexer.
You can find some information here: [CONTRIBUTING.md]

## LICENSE

Makeup is licensed under the BSD license.
This is the same license as the Pygments Makeup uses and
it seems to be compatible with the licenses used by all the dependencies.
