with renamed as (
    select order_id,
    product_id,
    quantity
    from {{ source('postgres', 'order_items') }}
)

select * from renamed