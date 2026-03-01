select
    customer_id,
    full_name,
    city,
    state,
    zip_code,
    geographic_location
from {{ ref('int_local_bike__customers_enriched') }}