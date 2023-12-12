/*Create a new table that is an inner join of consumption and total_deaths, based on Entity and Year match*/
CREATE TABLE smokers_data AS
SELECT
    c.*,  -- Select all columns from the 'consumption' table
    td.`share_deaths`  -- Select the 'share_deaths' column from the 'total_deaths' table
FROM
    consumption c
JOIN
    total_deaths td ON c.Entity = td.Entity AND c.Year = td.Year;






/*age_deaths table has less years than smokers_data*/
/*Create a new table that is a left join of smokers_data and age_deaths, based on Entity and Year match*/
/*1-Add the columns*/
ALTER TABLE smokers_data
ADD COLUMN death_70 double,
ADD COLUMN death_50_69 double,
ADD COLUMN death_15_49 double;
/*2-Do the join*/
UPDATE smokers_data sd
LEFT JOIN age_deaths ad ON sd.Entity = ad.Entity AND sd.Year = ad.Year
SET 
 sd.death_70 = ad.`70+`,
 sd.death_50_69 = ad.`50-69`,
 sd.death_15_49 = ad.`15-49`;
