-- Test: Staff member is their own manager (breaks hierarchy logic)
select
    staff_id
from {{ ref('int_local_bike__staff_enriched') }}
where staff_id = manager_id