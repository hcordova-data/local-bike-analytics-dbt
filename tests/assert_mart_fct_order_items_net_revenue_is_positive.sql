-- Test: Item net revenue should never be zero or negative after discount logic
select
    order_item_key
from {{ ref('fct_order_items') }}
where item_net_revenue <= 0