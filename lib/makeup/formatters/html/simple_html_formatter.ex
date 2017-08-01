defmodule Makeup.Formatters.HTML.SimpleHTMLFormatter do

  require EEx

  EEx.function_from_string(:defp, :render_token, """
  <span\
  <%= if css_class do %> class="<%= css_class %>"<% end %>\
  <%= if meta[:group_id] do %> data-group-id="<%= meta[:group_id] %>"<% end %>\
  ><%= escaped_value %></span>\
  """, [:escaped_value, :css_class, :meta])

  def format_token({tag, meta, value}) do
    escaped_value = HtmlEntities.encode(value)
    css_class = Makeup.Token.Utils.css_class_for_token_type(tag)
    render_token(escaped_value, css_class, meta)
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