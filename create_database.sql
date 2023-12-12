/*Create database */
CREATE DATABASE smokers;
USE smokers;

/*Create a table with the same fields as the data you have*/
/* Entity,Code,Year,"Cigarette consumption per smoker per day (IHME, GHDx (2012))","Consumption per smoker per day upper bound (IHME, GHDx (2012))","Consumption per smoker per day lower bound (IHME, GHDx (2012))"*/
CREATE TABLE IF NOT EXISTS consumption(
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
Entity VARCHAR(20),
Code VARCHAR(3),
Year YEAR,
`Cigarette consumption per smoker per day (IHME, GHDx (2012))` DOUBLE,
`Consumption per smoker per day upper bound (IHME, GHDx (2012))` DOUBLE, 
`Consumption per smoker per day lower bound (IHME, GHDx (2012))` DOUBLE
);

/*Load csv file into table*/
/*To do this, you need to have into the /etc/mysql/my.cnf file the lines "[mysqld] /n local_infile=1" and start mysql with --local-infile=1*/
/*Entity,Code,Year,
"Cigarette consumption per smoker per day (IHME, GHDx (2012))","Consumption per smoker per day upper bound (IHME, GHDx (2012))","Consumption per smoker per day lower bound (IHME, GHDx (2012))"*/
LOAD DATA LOCAL INFILE './data/consumption-per-smoker-per-day-bounds.csv'
INTO TABLE consumption
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(`Entity`, `Code`, `Year`, 
 `Cigarette consumption per smoker per day (IHME, GHDx (2012))`, 
 `Consumption per smoker per day upper bound (IHME, GHDx (2012))`, 
 `Consumption per smoker per day lower bound (IHME, GHDx (2012))`);

/*Rename columns to make them more readable*/
ALTER TABLE consumption RENAME COLUMN `Cigarette consumption per smoker per day (IHME, GHDx (2012))` TO consumption_day;
ALTER TABLE consumption RENAME COLUMN `Consumption per smoker per day upper bound (IHME, GHDx (2012))` TO consumption_day_upper;
ALTER TABLE consumption RENAME COLUMN `Consumption per smoker per day lower bound (IHME, GHDx (2012))` TO consumption_day_lower;

/*Create a table with the same fields as the data you have*/
/* Entity,Code,Year,"Share of total deaths that are from all causes attributed to smoking, in both sexes aged age-standardized"*/
CREATE TABLE IF NOT EXISTS total_deaths(
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
Entity VARCHAR(20),
Code VARCHAR(3),
Year YEAR,
share_deaths DOUBLE
);

/*Fill a table with different fields as the data you have*/
LOAD DATA LOCAL INFILE './data/share-deaths-smoking.csv'
INTO TABLE total_deaths
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(`Entity`, `Code`, `Year`, @csv_share_deaths)
SET
  share_deaths=@csv_share_deaths;

/*Create age_deaths table*/
/*Entity,Code,Year,"Deaths that are from all causes attributed to smoking, in both sexes aged 70+ years",
"Deaths that are from all causes attributed to smoking, in both sexes aged 50-69 years",
"Deaths that are from all causes attributed to smoking, in both sexes aged 15-49 years"
*/
CREATE TABLE IF NOT EXISTS age_deaths(
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
Entity VARCHAR(20),
Code VARCHAR(3),
Year YEAR,
`old` DOUBLE,
`midage` DOUBLE,
`young` DOUBLE
);

/*Fill a table with different fields as the data you have*/
LOAD DATA LOCAL INFILE './data/smoking-deaths-by-age.csv'
INTO TABLE age_deaths
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(`Entity`, `Code`, `Year`,
@csv_deaths_70, @csv_deaths_50_69, @csv_deaths_15_49)
SET
old=@csv_deaths_70,
midage=@csv_deaths_50_69,
young=@csv_deaths_15_49;


ALTER TABLE age_deaths RENAME COLUMN `old` TO `70+`;
ALTER TABLE age_deaths RENAME COLUMN `midage` TO `50-69`;
ALTER TABLE age_deaths RENAME COLUMN `young` TO `15-49`;
