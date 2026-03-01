with date_spine as (
    -- Generates a series of dates from 2016 to 2028
    select *
    from unnest(generate_date_array('2016-01-01', '2028-12-31', interval 1 day)) as date_day
)

select
    date_day as date_id,
    extract(year from date_day) as year,
    extract(month from date_day) as month,
    format_date('%B', date_day) as month_name,
    extract(quarter from date_day) as quarter,
    extract(dayofweek from date_day) as day_of_week,
    format_date('%A', date_day) as day_name,
    -- Financial/Ops Flags
    case when extract(dayofweek from date_day) in (1, 7) then true else false end as is_weekend,
    -- Useful for YTD/MTD comparisons in Power BI
    date_trunc(date_day, month) as month_start_date,
    last_day(date_day, month) as month_end_date
from date_spine