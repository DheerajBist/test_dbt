{% macro add_dd(var_date_string) %}
    Select cast( '{{ var_date_string }}' as DATE) + 1 
{% endmacro %}


  {%set add_date_query %}
     Select cast( '{{ var_date_string }}' as DATE) + 1 
  {% endset %} 

  {% set add_date_methods = run_query(add_date_query) %}

  {% if execute %}
        {% set add_date_list = add_date_methods.columns[0].values() %}
  {% else %}
        {% set add_date_list = [] %}
  {% endif %}  