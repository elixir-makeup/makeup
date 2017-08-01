defmodule Makeup.Token.DefTokenType do
  @moduledoc """
  Defines a helpful macro
  """

  @doc "Define a constant atom"
  defmacro deftokentype(name) do
    {atom, _, _} = name
    quote do
      defmacro unquote(name), do: unquote(atom)
    end
  end

end