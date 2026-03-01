select
    --Primary Key
    safe_cast(brand_id as int64) as brand_id,
    --Text Fields
    coalesce(cast(brand_name as string), 'Unknown Brand') as brand_name
from {{ source('local_bike', 'brands') }}