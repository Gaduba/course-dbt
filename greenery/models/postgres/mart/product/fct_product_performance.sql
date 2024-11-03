WITH product_performance AS (
    SELECT 
        pp.product_id,
        pp.product_name,
        COALESCE(pp.page_views, 0) AS page_views,
        COALESCE(pp.add_to_carts, 0) AS adds_to_cart,
        COALESCE(pp.checkouts, 0) AS checkout,
        COALESCE(pp.package_shippeds, 0) AS package_shipped,
        COALESCE(oi.total_quantity, 0) AS total_quantity_sold,
        COALESCE(oi.total_revenue, 0) AS total_revenue
    FROM {{ ref('i_product_views') }} pp
    LEFT JOIN (
        SELECT 
            product_id,
            SUM(quantity) AS total_quantity,
            SUM(item_total) AS total_revenue
        FROM {{ ref('i_order_items') }}
        GROUP BY product_id
    ) oi
    ON pp.product_id = oi.product_id
)

SELECT * 
FROM product_performance
