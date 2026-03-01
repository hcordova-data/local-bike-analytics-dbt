-- Test: For each product, the sum of pct_of_total_inventory_share across all stores must equal 100
select
    product_id,
    round(sum(pct_of_total_inventory_share), 0) as total_pct
from {{ ref('fct_stocks') }}
group by 1
having total_pct != 100
