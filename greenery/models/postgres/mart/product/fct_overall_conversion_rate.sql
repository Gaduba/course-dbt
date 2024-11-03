WITH sessions AS (
    SELECT 
        session_id,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout' THEN session_id END) AS purchase_sessions,
        COUNT(DISTINCT session_id) AS total_sessions
    FROM {{ ref('stg_events') }}
    GROUP BY session_id
),

conversion_rate AS (
    SELECT
        SUM(purchase_sessions) AS unique_purchase_sessions,
        SUM(total_sessions) AS total_unique_sessions,
        DIV0(SUM(purchase_sessions), SUM(total_sessions)) AS overall_conversion_rate
    FROM sessions
)

SELECT 
    unique_purchase_sessions,
    total_unique_sessions,
    overall_conversion_rate
FROM conversion_rate