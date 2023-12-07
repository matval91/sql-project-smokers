/*Create database */
CREATE DATABASE smokers;
USE smokers;

/*Create a table with the same fields as the data you have*/
/* Entity,Code,Year,"Cigarette consumption per smoker per day (IHME, GHDx (2012))","Consumption per smoker per day upper bound (IHME, GHDx (2012))","Consumption per smoker per day lower bound (IHME, GHDx (2012))"*/
CREATE TABLE IF NOT EXISTS consumption(
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
entity VARCHAR(20),
Code VARCHAR(3),
Year YEAR,
consumption_day DOUBLE,
consumption_upper DOUBLE,
consumption_lower DOUBLE
);

/*Load csv file into table*/
LOAD DATA LOCAL INFILE './data/consumption-per-smoker-per-day-bounds.csv' 
INTO TABLE consumption 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS(`Entity`,`Code`,`Year`,`Cigarette consumption per smoker per day (IHME, GHDx (2012))`,
  `Consumption per smoker per day upper bound (IHME, GHDx (2012))`,
  `Consumption per smoker per day lower bound (IHME, GHDx (2012))`
);