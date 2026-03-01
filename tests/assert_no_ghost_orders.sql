-- Test: Orders with no associated product (LEFT JOIN produced NULL product_id)
select
    order_id
from {{ ref('int_local_bike__orders_enriched') }}
where product_id is null