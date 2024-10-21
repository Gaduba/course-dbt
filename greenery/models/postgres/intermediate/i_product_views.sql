WITH product_views AS (
    SELECT 
        e.product_id,
        COUNT(CASE WHEN e.event_type = 'page_view' THEN 1 END) AS page_views,
        COUNT(CASE WHEN e.event_type = 'add_to_cart' THEN 1 END) AS adds_to_cart
    FROM {{ ref('stg_events') }} e
    WHERE e.product_id IS NOT NULL
    GROUP BY 1
    
)

SELECT 
    p.product_id,
    p.name as product_name,
    pv.page_views,
    pv.adds_to_cart
FROM product_views pv
JOIN {{ ref('stg_products') }} p
ON pv.product_id = p.product_id
