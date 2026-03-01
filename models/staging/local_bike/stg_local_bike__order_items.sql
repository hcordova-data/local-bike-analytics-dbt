select
    --Keys
    safe_cast(order_id as int64) as order_id,
    safe_cast(item_id as int64) as item_id,
    safe_cast(product_id as int64) as product_id,
    --Metrics
    safe_cast(quantity as int64) as quantity,
    safe_cast(list_price as numeric) as list_price,
    safe_cast(discount as numeric) as discount
from {{ source('local_bike', 'order_items') }}