select
    --Foreign Keys
    safe_cast(store_id as int64) as store_id,
    safe_cast(product_id as int64) as product_id,
    --Metrics
    coalesce(safe_cast(quantity as int64), 0) as quantity
from {{ source('local_bike', 'stocks') }}