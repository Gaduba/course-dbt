
with product_sessions as
(
    select * 
    from {{ ref('stg_events') }}
    where product_id is not null
),
purchase as
(
    select session_id
    from {{ ref('stg_events') }}
    where event_type = 'checkout'
)

select 
    s.session_id
    , s.product_id
    , sum(case when p.session_id is not null then 1
        else 0 end) as has_purchase
from product_sessions s
left join purchase p
on s.session_id = p.session_id
group by 1,2
order by s.product_id, s.session_id