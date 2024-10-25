with renamed as (
    select order_id,
    user_id,
    promo_id,
    address_id,
    created_at,
    order_cost,
    shipping_cost,
    order_total,
    shipping_service,
    estimated_delivery_at,
    delivered_at,
    status
    from {{ source('postgres', 'orders') }}
)

select * from renamed