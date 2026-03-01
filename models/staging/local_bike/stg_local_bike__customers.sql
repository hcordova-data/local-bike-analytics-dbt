select
    --Primary Key
    safe_cast(customer_id as int64) as customer_id,
    --Details
    cast(first_name as string) as first_name,
    cast(last_name as string) as last_name,
    cast(phone as string) as phone,
    cast(email as string) as email,
    cast(street as string) as street,
    cast(city as string) as city,
    cast(state as string) as state,
    cast(zip_code as string) as zip_code
from {{ source('local_bike', 'customers') }}