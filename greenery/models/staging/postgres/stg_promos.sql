with renamed as (
    select promo_id,
    discount,
    status
    from {{ source('postgres', 'promos') }}
)

select * from renamed