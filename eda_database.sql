/*Find the consumption of Italy*/
SELECT * FROM consumption
WHERE
    Entity = 'Italy';



/*Find the consumption of 1980*/
SELECT * FROM consumption
WHERE
    Year = 1980;



/*Find the consumption of Italy and Switzerland*/
SELECT * FROM consumption
WHERE
    Entity IN ('Italy', 'Switzerland');



/*List the top 5 contries (independently on the year) with higher consumption per day*/
SELECT Entity,consumption_day FROM consumption
ORDER BY
    consumption_day DESC
LIMIT 5;



/*Find the top 5 countries for consumption of 1980*/
SELECT Entity,consumption_day FROM consumption
WHERE
    Year = 1980
ORDER BY
    consumption_day DESC
LIMIT 5;



/*List the top 5 contries with lower consumption per day averaged over the years*/
SELECT
    Entity,
    AVG(consumption_day) AS avg_consumption_per_day
FROM
    consumption
GROUP BY
    Entity
ORDER BY
    avg_consumption_per_day
LIMIT 5;



/*Compute the year span for the different countries*/
SELECT
    Entity,
    MAX(Year)-MIN(Year) AS year_span
FROM consumption
GROUP BY
    Entity;



/*Compute the year span for the different countries, avoiding the years where consumption_day is null*/
SELECT
    Entity,
    MAX(Year)-MIN(Year) AS year_span
FROM consumption
WHERE 
    consumption_day IS NOT NULL
GROUP BY
    Entity;



/*Find countries which average consumption is larger than 30*/
SELECT
    Entity,
    AVG(consumption_day) AS avg_consumption_per_day
FROM consumption
GROUP BY
    Entity
HAVING 
    avg_consumption_per_day>30
ORDER BY
    avg_consumption_per_day;



/*Find countries which average consumption is larger than 30 and below 50*/
SELECT
    Entity,
    AVG(consumption_day) AS avg_consumption_per_day
FROM consumption
GROUP BY
    Entity
HAVING 
    avg_consumption_per_day>30 AND avg_consumption_per_day<50
ORDER BY
    avg_consumption_per_day;



/*[ADVANCED] Find the year where Italy had the maximum and minimum consumption*/
SELECT
    Entity,
    Year,
    consumption_day
FROM
    consumption
WHERE
    (Entity, consumption_day) IN (
        SELECT
            Entity,
            MAX(consumption_day) AS max_consumption
        FROM
            consumption
        WHERE
            Entity = 'Italy'
        GROUP BY
            Entity
        UNION
        SELECT
            Entity,
            MIN(consumption_day) AS min_consumption
        FROM
            consumption
        WHERE
            Entity = 'Italy'
        GROUP BY
            Entity
    );