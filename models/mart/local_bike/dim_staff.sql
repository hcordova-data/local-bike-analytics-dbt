select
    staff_id,
    full_name,
    store_id,
    employment_status,
    staff_role,
    manager_id
from {{ ref('int_local_bike__staff_enriched') }}