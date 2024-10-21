with renamed as (
    select address_id,
    address,
    state,
    country
    from {{ source('postgres', 'addresses') }}
)

select * from renamed