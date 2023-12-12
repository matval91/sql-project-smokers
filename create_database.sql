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
`Cigarette consumption per smoker per day (IHME, GHDx (2012))` DOUBLE,
`Consumption per smoker per day lower bound (IHME, GHDx (2012))` DOUBLE
);

/*Load csv file into table*/
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