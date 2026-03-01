-- Test: Customers with broken geographic_location due to NULL city, state or zip
select
    customer_id
from {{ ref('int_local_bike__customers_enriched') }}
where 
    city is null
    or state is null
    or zip_code is null