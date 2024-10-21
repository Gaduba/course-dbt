with renamed as (
    select user_id,
   first_name,
   last_name,
   email,
   phone_number,
   concat(first_name, ' ' ,last_name ) as full_name,
   created_at as sign_up_date,
   address_id
    from {{ source('postgres', 'users') }}
)

select * from renamed

