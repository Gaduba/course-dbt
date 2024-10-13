with renamed as (
    select product_id,
    name,
    price,
    inventory
    from {{ source('postgres', 'products') }}
)

select * from renamed

