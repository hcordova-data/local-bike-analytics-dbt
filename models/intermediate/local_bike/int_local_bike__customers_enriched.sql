select
    customer_id,
    --Combining names for a clean display in reports
    concat(first_name, ' ', last_name) as full_name,
    --Removing street and email for privacy and relevance
    city,
    state,
    zip_code,
    --Creating a geographic search key (helpful for map tools)
    concat(city, ', ', state, ' ', zip_code) as geographic_location
from {{ ref('stg_local_bike__customers') }}