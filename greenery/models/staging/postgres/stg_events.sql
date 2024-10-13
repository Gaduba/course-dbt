with renamed as (
    select event_id,
    session_id,
    user_id,
    created_at,
    event_type,
    order_id,
    product_id
    from {{ source('postgres', 'events') }}
)

select * from renamed
