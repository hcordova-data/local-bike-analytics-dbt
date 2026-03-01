-- Test: Products with zero or negative list price after enrichment
select
    product_id
from {{ ref('int_local_bike__products_enriched') }}
where list_price <= 0