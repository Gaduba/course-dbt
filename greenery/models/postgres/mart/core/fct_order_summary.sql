WITH order_summary AS (
    SELECT 
        os.order_id,
        os.user_id,
        os.order_date,
        os.full_name,
        os.phone_number,
        os.email,
        uf.delivered_at,
        uf.order_status,
        uf.state,
        uf.country,
        COALESCE(uf.shipping_time, 0) AS shipping_time,
        oi.product_name,
        COUNT(oi.product_id) AS total_items,
        SUM(oi.quantity) AS total_quantity,
        SUM(oi.item_total) AS total_revenue
    FROM {{ ref('i_order_summary') }} os
    LEFT JOIN {{ ref('i_order_fulfilment') }} uf
    ON os.order_id = uf.order_id
    LEFT JOIN {{ ref('i_order_items') }} oi
    ON os.order_id = oi.order_id
    GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12
)

SELECT * 
FROM order_summary
