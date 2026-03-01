select
    stores.store_id,
    stores.store_name,
    stores.city,
    stores.state,
    stores.zip_code,
    -- Creating a display field for dashboards
    concat(stores.city, ' (', stores.state, ')') as store_location,
    -- Enrichment: Calculating the number of employees at this location
    coalesce(staff_counts.total_staff, 0) as total_staff_count
from {{ ref('stg_local_bike__stores') }} as stores
left join (
    -- Subquery to aggregate staff by store
    select 
        store_id, 
        count(staff_id) as total_staff 
    from {{ ref('stg_local_bike__staff') }} 
    where active = 1
    group by 1
    ) as staff_counts
    on stores.store_id = staff_counts.store_id