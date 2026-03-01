select
    -- Keys from both tables
    orders.order_id,
    order_items.item_id,
    order_items.product_id,
    orders.customer_id,
    orders.store_id,
    orders.staff_id,
    -- Order Details
    orders.order_status,
    orders.order_date,
    orders.required_date,
    orders.shipped_date,
    -- Item Metrics (Will be NULL if no items exist)
    order_items.quantity,
    order_items.list_price,
    order_items.discount
from {{ ref('stg_local_bike__orders') }} as orders
left join {{ ref('stg_local_bike__order_items') }} as order_items
    on orders.order_id = order_items.order_id