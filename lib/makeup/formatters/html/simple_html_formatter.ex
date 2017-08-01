defmodule Makeup.Formatters.HTML.SimpleHTMLFormatter do

  def format_token({tag, _meta, value}) do
    escaped = HtmlEntities.encode(value)
    css_class = Makeup.Token.Utils.css_class_for_token_type(tag)
    case css_class do
      nil -> "<span>#{escaped}</span>"
      css_class -> ~s(<span class="#{css_class}">#{escaped}</span>)
    end
  end

  def format(tokens, css_class \\ "highlight") do
    inner = tokens
    |> Enum.map(&format_token/1)
    |> Enum.join("")

    """
    <pre class="#{css_class}"><code>#{inner}</code></pre>
    """
  end

  def stylesheet(style, css_class \\ "highlight") do
    Makeup.Styles.HTML.Style.stylesheet(style, css_class)
  end
end