WITH order_fulfillment AS (
    SELECT 
        o.order_id,
        o.user_id,
        o.created_at as order_date,
        o.status as order_status,
        a.state,
        a.country,
        o.delivered_at,
        DATEDIFF(day, o.created_at, o.delivered_at) AS shipping_time
    FROM {{ ref('stg_orders') }} o
    LEFT JOIN {{ ref('stg_addresses') }} a
    ON o.address_id = a.address_id
)

SELECT * 
FROM order_fulfillment
