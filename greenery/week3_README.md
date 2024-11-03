# Part One
To answer these questions, I created three new models:
- `i_product_checkout`
- `fct_overall_conversion_rate`
- `fct_product_converson_rate`

## What is our overall conversion rate?
### Answer: 62.5% 
```
WITH sessions AS (
    SELECT 
        session_id,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout' THEN session_id END) AS purchase_sessions,
        COUNT(DISTINCT session_id) AS total_sessions
    FROM {{ ref('stg_events') }}
    GROUP BY session_id
),

conversion_rate AS (
    SELECT
        SUM(purchase_sessions) AS unique_purchase_sessions,
        SUM(total_sessions) AS total_unique_sessions,
        DIV0(SUM(purchase_sessions), SUM(total_sessions)) AS overall_conversion_rate
    FROM sessions
)

SELECT 
    unique_purchase_sessions,
    total_unique_sessions,
    overall_conversion_rate
FROM conversion_rate
```

## What is our conversion rate by product?
### Answer: Avg. conversion rate = 77.5%
```
with product_events as
(
    select
    *
    from {{ ref('i_product_checkout') }}
)


select 
    product_id, 
    count(distinct session_id) as total_sessions,
    count_if(has_purchase = true) as sessions_with_purchase,
    round(cast(count_if(has_purchase = true) as float) / cast(count(distinct session_id) as float), 3) as conversion_rate
from product_events
group by product_id
order by product_id;
```

# Part Two: Macros
I created a macro to return the sum of event for any event type specified:
```
{% macro sum_of(col_name, col_value) %}

sum(case when {{col_name}} = '{{col_value}}' then 1 else 0 end )

{% endmacro %}
```

I used the macro in an intermediate model `i_product_views.sql`
```
{% set event_types = ['page_view', 'add_to_cart','checkout', 'package_shipped'] %}


    SELECT 
        e.product_id,
        p.name as product_name,
        {% for event_type in event_types %}
        {{sum_of ('e.event_type', event_type) }} as {{ event_type }}s,
        {% endfor %}
    FROM {{ ref('stg_events') }} e
    JOIN {{ ref('stg_products') }} p
    ON e.product_id = p.product_id
    WHERE e.product_id IS NOT NULL
    GROUP BY 1,2
    
```


# Part Three: Hooks
I added the `grant` macro and added the post-hook to my dbt project yml.

```

{% macro grant_select_on_schemas(schemas, user) %}

  {% for schema in schemas %}
    grant usage on schema {{ schema }} to "{{ user }}";
    grant select on all tables in schema {{ schema }} to "{{ user }}";
    alter default privileges in schema {{ schema }}
        grant select on tables to "{{ user }}";
  {% endfor %}
{% endmacro %}

```

# Part Four: Packages
I installed `dbt_utils` to ascertain the recency of the data and configured it to warn me against stale data:
```
 version: 2

models:
  - name: fct_order_summary
    columns:
      - name: order_id
        tests:
          - not_null
          - dbt_utils.recency:
            datepart: day
            field: order_date
            interval: 1
            config: warn

```
