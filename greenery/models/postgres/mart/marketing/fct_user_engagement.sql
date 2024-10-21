WITH user_engagement AS (
    SELECT 
        ue.user_id,
        ue.total_orders,
        ue.total_spend,
        ue.total_page_views,
        ue.total_adds_to_cart,
        CASE 
            WHEN ue.total_orders >= 2 THEN 'Repeat Customer'
            ELSE 'Single Purchase Customer'
        END AS customer_type
    FROM {{ ref('i_user_engagement') }} ue
)

SELECT * 
FROM user_engagement