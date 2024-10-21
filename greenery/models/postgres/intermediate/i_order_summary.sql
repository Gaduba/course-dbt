WITH order_summary AS (
    SELECT 
        o.order_id,
        o.user_id,
        u.full_name,
        u.phone_number,
        u.email,
        o.created_at as order_date,
        o.order_cost,
        o.order_total,
        o.shipping_cost,
        a.state
    FROM {{ ref('stg_orders') }} o
    LEFT JOIN {{ ref('stg_users') }} u ON u.user_id = o.user_id
    LEFT JOIN {{ ref('stg_addresses') }} a ON a.address_id = u.address_id
    GROUP BY 1,2,3,4,5,6,7,8,9,10
)

SELECT * 
FROM order_summary
