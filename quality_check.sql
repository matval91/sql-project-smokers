/*Check a table has unique values in the entity
This is the output
+----------------+-----------------+
| total_entities | unique_entities |
+----------------+-----------------+
|           6204 |             188 |
+----------------+-----------------+
1 row in set (0.00 sec)
*/
SELECT
    COUNT(entity) AS total_entities,
    COUNT(DISTINCT entity) AS unique_entities
FROM
    consumption;

/*Check a table has unique values in the entity for a fixed year
This is the output
+----------------+-----------------+
| total_entities | unique_entities |
+----------------+-----------------+
|            188 |             188 |
+----------------+-----------------+
1 row in set (0.00 sec)
*/
SELECT
    COUNT(entity) AS total_entities,
    COUNT(DISTINCT entity) AS unique_entities
FROM
    consumption
WHERE
    Year = 2010;

/*Check if a table has unique values in the entity AND in the code
This is the output
+--------------+---------------+
| unique_codes | unique_entity |
+--------------+---------------+
|          188 |           188 |
+--------------+---------------+
1 row in set (0.00 sec)
*/
SELECT
    COUNT(DISTINCT code) AS unique_codes,
    COUNT(DISTINCT entity) AS unique_entity
FROM
    consumption;

/*Check the year span for the different countries
This is the output
+----------------------+-----------+
| Entity               | year_span |
+----------------------+-----------+
| Afghanistan          |        32 |
| Albania              |        32 |
| Algeria              |        32 |
| Andorra              |        32 |
...
| World                |        32 |
| Yemen                |        32 |
| Zambia               |        32 |
| Zimbabwe             |        32 |
+----------------------+-----------+
188 rows in set (0.01 sec)
*/
SELECT
    Entity,
    MAX(Year)-MIN(Year) AS year_span
FROM consumption
GROUP BY
    Entity;