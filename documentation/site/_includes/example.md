{::options parse_block_html="true" /}
<div class="example-container">
  <div class="content">{{ include.content }}</div>
  {% if include.result %}
    {{ include.result }}
  {% endif %}
</div>
{::options parse_block_html="false" /}