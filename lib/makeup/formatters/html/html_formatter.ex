defmodule Makeup.Formatters.HTML.HTMLFormatter do

  require EEx

  EEx.function_from_string(:defp, :render_token, """
  <span\
  <%= if css_class do %> class="<%= css_class %>"<% end %>\
  <%= if meta[:group_id] do %> data-group-id="<%= meta[:group_id] %>"<% end %>\
  ><%= escaped_value %></span>\
  """, [:escaped_value, :css_class, :meta])

  def format_token({tag, meta, value}) do
    escaped_value = escape(value)
    css_class = Makeup.Token.Utils.css_class_for_token_type(tag)
    render_token(escaped_value, css_class, meta)
  end

  defp escape(string) do
    escape_map = [{"&", "&amp;"}, {"<", "&lt;"}, {">", "&gt;"}, {~S("), "&quot;"}]
    Enum.reduce escape_map, string, fn {pattern, escape}, acc ->
      String.replace(acc, pattern, escape)
    end
  end

  def format_inner(tokens) do
    tokens
    |> Enum.map(&format_token/1)
    |> Enum.join("")
  end

  def format(tokens, css_class \\ "highlight") do
    inner = format_inner(tokens)

    """
    <pre class="#{css_class}"><code>#{inner}</code></pre>
    """
  end

  def stylesheet(style, css_class \\ "highlight") do
    Makeup.Styles.HTML.Style.stylesheet(style, css_class)
  end

  def group_highlighter_javascript() do
    """
    function makeupProcessMatchingGroups() {
      var HIGHLIGHT_CLASS = "hll";
      function onMouseEnter(evt) {
        var groupId = evt.target.getAttribute("data-group-id");
        siblings = document.querySelectorAll("[data-group-id='" + groupId + "']");
        for (i = 0; i < siblings.length; ++i) {
          siblings[i].classList.add(HIGHLIGHT_CLASS);
        }
      }

      function onMouseLeave(evt) {
        var groupId = evt.target.getAttribute("data-group-id");
        siblings = document.querySelectorAll("[data-group-id='" + groupId + "']");
        for (i = 0; i < siblings.length; ++i) {
          siblings[i].classList.remove(HIGHLIGHT_CLASS);
        }
      }

      var delims = document.querySelectorAll("[data-group-id]");
      for(i=0; i < delims.length; i++) {
        var elem = delims[i];
        elem.addEventListener("mouseenter", onMouseEnter);
        elem.addEventListener("mouseleave", onMouseLeave);
      }
    }

    makeupProcessMatchingGroups();
    """
  end
end