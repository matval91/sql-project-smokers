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

LOAD DATA LOCAL INFILE './data/share-deaths-smoking.csv'
INTO TABLE total_deaths
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(`Entity`, `Code`, `Year`, 
  @share_deaths)
SET
 `Share of total deaths that are from all causes attributed to smoking, in both sexes aged age-standardized` = NULLIF(@share_deaths, '');