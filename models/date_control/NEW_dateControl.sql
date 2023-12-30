
-- ### Date - Control process ####

with orig_date_table as (
Select * from public.daily_date_control 
)

with holiday_table as (
Select * from public.holiday_table 
)

