WITH user_engagement AS (
    SELECT 
        u.user_id,
        COUNT(o.order_id) AS total_orders,
        SUM(o.order_cost) AS total_spend,
        COUNT(CASE WHEN e.event_type = 'page_view' THEN 1 END) AS total_page_views,
        COUNT(CASE WHEN e.event_type = 'add_to_cart' THEN 1 END) AS total_adds_to_cart
    FROM {{ ref('stg_users') }} u
    LEFT JOIN {{ ref('stg_orders') }} o
    ON u.user_id = o.user_id
    LEFT JOIN {{ ref('stg_events') }} e
    ON u.user_id = e.user_id
    GROUP BY u.user_id
)

SELECT * 
FROM user_engagement
