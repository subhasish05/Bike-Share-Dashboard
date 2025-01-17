# Create Data base bike_data.
create database bike_data;

use  bike_data;

# View the bike_share_yr_0 table.
select * from bike_share_yr_0;

# View the bike_share_yr_1 table.
select * from bike_share_yr_1;

# View the cost_table table.
select * from cost_table;


# Merge the two table bike_share_yr_0 and bike_share_yr_1 and store it in bike_share_data.
create table bike_share_data as
select dteday, season, yr, weekday, hr, rider_type, riders from bike_share_yr_0
union all 
select dteday, season, yr, weekday, hr, rider_type, riders from bike_share_yr_1;

# View the merhged table bike_share_data.
select * from bike_share_data;

# Align the bike_share_data table in descending order as per year.
SELECT * 
FROM bike_share_data 
ORDER BY yr DESC 
LIMIT 5;

# Merged the bike_share_data and cost_table and name it as bike_share_final. 
CREATE TABLE bike_share_final AS
SELECT bike_share_data.*, cost_table.price, cost_table.COGS
FROM bike_share_data
LEFT JOIN cost_table
ON bike_share_data.yr = cost_table.yr;

# View the bike_share_final table. 
select * from bike_share_final;

# Add column revenue and profit in bike_share_final table. 
ALTER TABLE bike_share_final
ADD COLUMN revenue DECIMAL(10, 2),
ADD COLUMN profit DECIMAL(10, 2);

# Add the vales in revenue and profit columns. 
UPDATE bike_share_final
SET revenue = riders * price,
    profit = (riders * price) - (COGS*riders);
   
   # Confirm the table. 
    select * from bike_share_final;
    