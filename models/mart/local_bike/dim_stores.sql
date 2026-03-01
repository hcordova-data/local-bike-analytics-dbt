select
    store_id,
    store_name,
    city,
    state,
    zip_code,
    total_staff_count
from {{ ref('int_local_bike__stores_enriched') }}