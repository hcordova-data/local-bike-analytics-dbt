with orders_enriched as (
    select * from {{ ref('int_local_bike__orders_enriched') }}
)
select distinct
    -- 1. Header Keys
    order_id,
    customer_id,
    store_id,
    staff_id,
    -- 2. Header Dates
    order_date,
    required_date,
    shipped_date, 
    -- 3. Header-Level Aggregations (using Window Functions)
    -- This calculates the total for the whole order, even though it's looking at lines
    sum(quantity) over(partition by order_id) as total_items_quantity,
    round(
        sum((quantity * list_price) * (1 - discount)) over(partition by order_id), 
    2) as total_order_revenue,
    -- 4. Operational Logic
    -- If any one item in the order was delayed, the whole order is flagged (max=1)
    max(case when shipped_date > required_date then 1 else 0 end) over(partition by order_id) as is_order_delayed, 
    date_diff(shipped_date, order_date, day) as days_to_ship,
    -- 5. Customer Loyalty
    case 
        when order_date = min(order_date) over(partition by customer_id) then 'New'
        else 'Repeat' 
    end as customer_type
from orders_enriched