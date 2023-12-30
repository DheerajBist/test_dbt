
{% macro add_daily_date(table_name,field_name,holiday_table) %}
  {% set loop_cnt = 5 %}


  {{ print("*****   Running add_daily_date :: " ~ table_name ~ "," ~ field_name ~ "," ~ holiday_table ) }}
  {{ print("***** Loop valie :: " ~ loop_cnt) }}

  {%set c_date_query %}
    Select  cast( {{ field_name }} as varchar ) from {{ table_name }}
  {% endset %} 

  {% set c_date_methods = run_query(c_date_query) %}

  {% if execute %}
        {% set c_date_list = c_date_methods.columns[0].values() %}
  {% else %}
        {% set c_date_list = [] %}
  {% endif %}  
  {{ print("*****  -->  :: Current date var curr_date_list  :: " ~ c_date_list ) }}
  {% set ns = namespace(curr_date=c_date_list[0]) %} 
  {{ print("*****  -->  :: Current date varable   :: " ~ curr_date ) }}


  {% if holiday_table is defined %}
       {% set holiday_query %}
         SELECT DISTINCT date_char FROM {{ holiday_table }} ORDER BY 1
       {% endset %}

       {% set holiday_methods = run_query(holiday_query) %}

     {% if execute %}
           {% set holiday_methods_list = holiday_methods.columns[0].values() %}
     {% else %}
           {% set holiday_methods_list = [] %}
     {% endif %}

         {{ print("*****  -->  :: holiday_methods_list :: " ~ holiday_methods_list ) }}

  {% else %}
     {{ print("*****  -->  :: NO Holiday lookup table passed  :: " ) }}
  {% endif %}



  {% for i in range(0, loop_cnt) %}
     {{ print("*****  -->  Loop Counter  :: " ~ i ~ " , of the  Loop_CnT :: " ~ loop_cnt ) }}
     {% if ns.curr_date in holiday_methods_list %}
       {{ print("*****  -->  Holiday date matched  for :: " ~ ns.curr_date ) }}
       {{ print("*****  -->  Adding +1 date") }}
            {%set add_date_query %}
                 Select cast( '{{ ns.curr_date }}' as DATE) + 1 
            {% endset %} 
            {% set add_date_methods = run_query(add_date_query) %}
            {% if execute %}
            {% set add_date_list = add_date_methods.columns[0].values() %}
            {% else %}
            {% set add_date_list = [] %}
            {% endif %}  
   {% set ns.curr_date = add_date_list[0] %}
       {{ print("################  -->  Holiday date update to  :: " ~ curr_date ~ "|" ~ c_date_list[0]  ) }}
     {% endif %}
  {% endfor %}

  Select * from public.daily_date_control 

{% endmacro %}