-- Test: Total order revenue rolled up via window function should never be negative
select
    order_id
from {{ ref('fct_orders') }}
where total_order_revenue <= 0