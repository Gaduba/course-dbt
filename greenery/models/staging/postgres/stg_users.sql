with renamed as (
    select user_id,
   first_name,
   last_name,
   concat(first_name, ' ' ,last_name ) as full_name
    from {{ source('postgres', 'users') }}
)

select * from renamed

