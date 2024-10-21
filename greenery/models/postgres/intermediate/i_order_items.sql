WITH order_items_details AS (
    SELECT 
        oi.order_id,
        oi.product_id,
        oi.quantity,
        p.price,
        p.name as product_name,
        oi.quantity * p.price as item_total
    FROM {{ ref('stg_order_items') }} oi
    LEFT JOIN {{ ref('stg_products') }} p
    ON oi.product_id = p.product_id
)

SELECT * 
FROM order_items_details