{% macro get_exchange_rates(column1, column2) %}

json_extract({{column1}}, '$."{{ column2}}"' )

{% endmacro %}
