RELEASE_TYPE: minor

Adds a register where lexer developers can register their lexers.
This allows one to pick a lexer based on the language name.

The goal is for Makeup to be aware of the avaliable lexers.
In a project such as ExDoc this allows Makeup to support an unbounded number of languages just by declaring the lexer as a dependency.