select
    staffs.staff_id,
    --Concatenating names for better usability in Power BI
    concat(staffs.first_name, ' ', staffs.last_name) as full_name,
    staffs.store_id,
    --Converting numeric status to human-readable text
    case 
        when staffs.active = 1 then 'Active'
        else 'Inactive'
        end as employment_status,
    --Categorizing staff roles by checking if their ID appears as a manager for others
    case 
        when managers_list.manager_id is not null then 'Manager'
        else 'Individual Contributor'
        end as staff_role,
    --Identifying the top-level hierarchy
    case 
        when staffs.manager_id is null then 'Top Manager'
        else 'Reports to Manager'
        end as hierarchy_level,
    staffs.manager_id
from {{ ref('stg_local_bike__staff') }} as staffs
--This join identifies if the current staff member is a manager of someone else
left join (select distinct manager_id from {{ ref('stg_local_bike__staff') }}) as managers_list
    on staffs.staff_id = managers_list.manager_id