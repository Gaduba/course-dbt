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
    
