with orders_base as (
    select * from {{ ref('int_local_bike__orders_enriched') }}
)

select
    -- 1. Keys & IDs (Grain: Order + Item)
    concat(cast(order_id as string), '-', cast(item_id as string)) as order_item_key,
    order_id,
    item_id,
    product_id,
    customer_id,
    store_id,
    staff_id,
    
    -- 2. Dates
    order_date,
    required_date,
    shipped_date,
    
    -- 3. Metrics (Atomic Level)
    quantity,
    list_price,
    discount,
    round((quantity * list_price) * (1 - discount), 2) as item_net_revenue,

    -- 4. Flags & Intelligence
    date_diff(shipped_date, order_date, day) as days_to_ship,
    
    case 
        when shipped_date > required_date then 1 
        else 0 
    end as is_item_delayed,

    count(item_id) over(partition by order_id) as items_in_this_order,

    case 
        when order_date = min(order_date) over(partition by customer_id) then 'New'
        else 'Repeat' 
    end as customer_at_order_type

from orders_base