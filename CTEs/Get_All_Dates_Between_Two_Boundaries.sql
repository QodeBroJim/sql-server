-- Declare and initialize date parameters
declare @LowerDate date, @UpperDate date
set @LowerDate = dateadd(month, datediff(month, -1, getdate()) - 2, 0) -- set @LowerDate to first day of previous month
set @UpperDate = dateadd(ss, -1, dateadd(month, datediff(month, 0, getdate()), 0)) -- set @UpperDate to last day of previous month
-- select @LowerDate, @UpperDate


-- Create CTE to calculate dates between @LowerDate and @UpperDate then store values in temp table
;with Dates as 
(
	select top
		(datediff(day, @LowerDate, @UpperDate) + 1) 
		[DayOfMonth] = dateadd(day, row_number() over(order by a.object_id) - 1, @LowerDate)
	from sys.all_objects a
	cross join sys.all_objects b
) 
select 
	[DayOfMonth]
into #Temp 
from Dates