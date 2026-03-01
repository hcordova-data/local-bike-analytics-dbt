select
    products.product_id,
    -- Strips ' - ' followed by 4 digits at the very end of the name
    regexp_replace(products.product_name, r' - \d{4}$', '') as product_name,
    products.model_year,
    products.list_price,
    brands.brand_name,
    categories.category_name
from {{ ref('stg_local_bike__products') }} as products
left join {{ ref('stg_local_bike__brands') }} as brands 
    on products.brand_id = brands.brand_id
left join {{ ref('stg_local_bike__categories') }} as categories 
    on products.category_id = categories.category_id