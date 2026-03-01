with stocks_base as (
    select * from {{ ref('stg_local_bike__stocks') }}
)

select
    -- 1. Keys (The Joins)
    store_id,
    product_id,
    -- 2. Current State
    quantity,
    -- 3. Operational Health Flags
    -- These categorizations allow for instant "Red/Yellow/Green" status in dashboards
    case 
        when quantity = 0 then 'Out of Stock'
        when quantity <= 5 then 'Low Stock (Critical)'
        when quantity <= 20 then 'Healthy'
        else 'Overstocked' 
    end as inventory_status_label,

    -- 4. Distribution Intelligence
    -- Calculates the % of this specific product's total inventory held at this store.
    -- High % in a low-sales store = Redistribution Opportunity.
    round(
        safe_divide(
            quantity, 
            sum(quantity) over(partition by product_id)
        ) * 100, 2
    ) as pct_of_total_inventory_share,

    -- 5. Store Concentration
    -- Does this product represent a huge portion of this specific store's total units?
    round(
        safe_divide(
            quantity, 
            sum(quantity) over(partition by store_id)
        ) * 100, 2
    ) as pct_of_store_total_volume
from stocks_base