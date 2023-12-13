/*Find the consumption of Italy
This is the output
+------+--------+------+------+-----------------+-----------------------+-----------------------+
| id   | Entity | Code | Year | consumption_day | consumption_day_upper | consumption_day_lower |
+------+--------+------+------+-----------------+-----------------------+-----------------------+
| 2740 | Italy  | ITA  | 1980 |       20.700001 |                  22.5 |                  19.1 |
| 2741 | Italy  | ITA  | 1981 |       20.299999 |                    22 |                  18.9 |
| 2742 | Italy  | ITA  | 1982 |            20.1 |             21.700001 |             18.700001 |
...
+------+--------+------+------+-----------------+-----------------------+-----------------------+
33 rows in set (0.00 sec)
*/
SELECT * FROM consumption
WHERE
    Entity = 'Italy';



/*Find the consumption of 1980
This is the output
+------+----------------------+------+------+-----------------+-----------------------+-----------------------+
| id   | Entity               | Code | Year | consumption_day | consumption_day_upper | consumption_day_lower |
+------+----------------------+------+------+-----------------+-----------------------+-----------------------+
|    1 | Afghanistan          | AFG  | 1980 |       5.6999998 |             7.3000002 |             4.5999999 |
|   34 | Albania              | ALB  | 1980 |       18.700001 |                  23.6 |                  14.6 |
|   67 | Algeria              | DZA  | 1980 |            19.1 |                  23.1 |                  16.1 |
|  100 | Andorra              | AND  | 1980 |            17.6 |                    82 |                   1.2 |
...
| 6073 | World                | OWI  | 1980 |       18.799999 |             19.799999 |                    18 |
| 6106 | Yemen                | YEM  | 1980 |            29.5 |             35.799999 |                  24.4 |
| 6139 | Zambia               | ZMB  | 1980 |            12.2 |                    19 |             7.6999998 |
| 6172 | Zimbabwe             | ZWE  | 1980 |              29 |             37.400002 |                  22.1 |
+------+----------------------+------+------+-----------------+-----------------------+-----------------------+
188 rows in set (0.01 sec)

*/
SELECT * FROM consumption
WHERE
    Year = 1980;



/*Find the consumption of Italy and Switzerland
This is the output
+------+-------------+------+------+-----------------+-----------------------+-----------------------+
| id   | Entity      | Code | Year | consumption_day | consumption_day_upper | consumption_day_lower |
+------+-------------+------+------+-----------------+-----------------------+-----------------------+
| 2740 | Italy       | ITA  | 1980 |       20.700001 |                  22.5 |                  19.1 |
| 2741 | Italy       | ITA  | 1981 |       20.299999 |                    22 |                  18.9 |
| 2742 | Italy       | ITA  | 1982 |            20.1 |             21.700001 |             18.700001 |
| 2743 | Italy       | ITA  | 1983 |            19.9 |                  21.5 |                  18.6 |
...
| 5375 | Switzerland | CHE  | 2008 |       25.200001 |                  28.1 |                  22.6 |
| 5376 | Switzerland | CHE  | 2009 |            24.6 |                  27.9 |             21.700001 |
| 5377 | Switzerland | CHE  | 2010 |            23.9 |                  27.4 |             20.799999 |
| 5378 | Switzerland | CHE  | 2011 |       23.200001 |                  26.9 |                    20 |
| 5379 | Switzerland | CHE  | 2012 |            22.5 |                  26.4 |             19.200001 |
+------+-------------+------+------+-----------------+-----------------------+-----------------------+
66 rows in set (0.00 sec)

*/
SELECT * FROM consumption
WHERE
    Entity IN ('Italy', 'Switzerland');



/*List the top 5 contries (independently on the year) with higher consumption per day
This is the output
+----------------------+-----------------+
| Entity               | consumption_day |
+----------------------+-----------------+
| Saint Vincent and th |       135.89999 |
| Saint Vincent and th |       133.10001 |
| Saint Vincent and th |       130.39999 |
| Suriname             |           129.3 |
| Saint Vincent and th |           127.5 |
+----------------------+-----------------+
5 rows in set (0.00 sec)
*/
SELECT Entity,consumption_day FROM consumption
ORDER BY
    consumption_day DESC
LIMIT 5;



/*Find the top 5 countries for consumption of 1980
This is the output
+----------------------+-----------------+
| Entity               | consumption_day |
+----------------------+-----------------+
| Saint Vincent and th |       135.89999 |
| Suriname             |           129.3 |
| Antigua and Barbuda  |           119.5 |
| Saudi Arabia         |              74 |
| Equatorial Guinea    |       65.099998 |
+----------------------+-----------------+
5 rows in set (0.00 sec)
*/
SELECT Entity,consumption_day FROM consumption
WHERE
    Year = 1980
ORDER BY
    consumption_day DESC
LIMIT 5;



/*List the top 5 contries with lower consumption per day averaged over the years
This is the output
+--------------+-------------------------+
| Entity       | avg_consumption_per_day |
+--------------+-------------------------+
| East Timor   |      1.7151515030303024 |
| Chad         |       1.893939363636364 |
| Guinea       |      2.0969696666666664 |
| Bolivia      |       2.587878784848485 |
| Burkina Faso |       3.448484863636364 |
+--------------+-------------------------+
5 rows in set (0.01 sec)
*/
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




/*Compute the year span for the different countries, avoiding the years where consumption_day is null*/
SELECT
    Entity,
    MAX(Year)-MIN(Year) AS year_span
FROM consumption
WHERE 
    consumption_day IS NOT NULL
GROUP BY
    Entity;



/*Find countries which average consumption is larger than 30. Order them by the average consumption
The output is
+----------------------+-------------------------+
| Entity               | avg_consumption_per_day |
+----------------------+-------------------------+
| Slovenia             |      30.248484939393947 |
| Togo                 |      30.403030424242424 |
| Barbados             |      31.657575424242424 |
| Brazil               |       31.99393912121213 |
| Libya                |       32.80909096969697 |
| Bhutan               |      34.524242363636354 |
| Eritrea              |       35.02121196969698 |
| Cuba                 |       35.91212169696971 |
| Belize               |       37.98484848484848 |
| Malta                |      38.366666606060605 |
| Oman                 |      38.403030393939396 |
| Equatorial Guinea    |       40.85757545454546 |
| Brunei               |       44.36666675757575 |
| Saudi Arabia         |       51.09090909090908 |
| Antigua and Barbuda  |       67.64242415151514 |
| Saint Vincent and th |       102.4818174848485 |
| Suriname             |      118.68181818181822 |
+----------------------+-------------------------+
17 rows in set (0.01 sec)
*/
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



/*Find countries which average consumption is larger than 30 and below 50. Order them by consumption per day
The output is
+-------------------+-------------------------+
| Entity            | avg_consumption_per_day |
+-------------------+-------------------------+
| Slovenia          |      30.248484939393947 |
| Togo              |      30.403030424242424 |
| Barbados          |      31.657575424242424 |
| Brazil            |       31.99393912121213 |
| Libya             |       32.80909096969697 |
| Bhutan            |      34.524242363636354 |
| Eritrea           |       35.02121196969698 |
| Cuba              |       35.91212169696971 |
| Belize            |       37.98484848484848 |
| Malta             |      38.366666606060605 |
| Oman              |      38.403030393939396 |
| Equatorial Guinea |       40.85757545454546 |
| Brunei            |       44.36666675757575 |
+-------------------+-------------------------+
13 rows in set (0.01 sec)
*/
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



/*[ADVANCED] Find the year where Italy had the maximum and minimum consumption
This is the output
+--------+------+-----------------+
| Entity | Year | consumption_day |
+--------+------+-----------------+
| Italy  | 1990 |       18.700001 |
| Italy  | 2000 |            21.9 |
+--------+------+-----------------+
2 rows in set (13.38 sec)
*/
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