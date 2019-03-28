with cleaned_input as (
    select customer_id{% for p in predictors %}
        , case when {{ p['name'] }} is null
            then {{ p['fill_na'] }}
            else {{ p['name'] }} end
            as {{ p['name'] }} {% endfor %}{% if train %}
        , income{% endif %}
    from customer_attr{% if train %}
    where customer_id % 10 = 0 --10% sample
        and income is not null{% endif %}
)
{%if train %}
select * from cleaned_input
{% else %}
select customer_id
    , {{ coefs['intercept'] }}{% for p in predictors %}
        + {{ coefs[p['name']] }}*{{ p['name'] }}{% endfor %}
        as predicted_income
from cleaned_input
{% endif %}