select
    --Primary Key
    safe_cast(order_id as int64) as order_id,
    --Foreign Keys
    safe_cast(customer_id as int64) as customer_id,
    safe_cast(store_id as int64) as store_id,
    safe_cast(staff_id as int64) as staff_id,
    --Status & Dates
    safe_cast(order_status as int64) as order_status,
    safe_cast(order_date as date) as order_date,
    safe_cast(required_date as date) as required_date,
    safe_cast(shipped_date as date) as shipped_date
from {{ source('local_bike', 'orders') }}