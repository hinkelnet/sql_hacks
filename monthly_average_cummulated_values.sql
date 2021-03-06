/******************************************************************************************
Description:

UseCase: Monthly average cummulated values 

SOURCE TABLE:

Table: CLIENT_ACCOUNT

CLIENT_ID   YEAR    MONTH   RECORD_DATE  ACTUAL_VOLUME   
123456      2018    1       01.01.2018   1000   
123456      2018    1       02.01.2018   1500  
123456      2018    1       31.01.2018   2000 
123456      2018    2       01.02.2018    100 
123456      2018    2       15.02.2018    900 

RESULT 

CLIENT_ID   YEAR    MONTH   RECORD_DATE  ACTUAL_VOLUME   CALC_CUM_AVG_INVESTMENT   
123456      2018    1       01.01.2018   1000            1000
123456      2018    1       02.01.2018   1500            1250
123456      2018    1       31.01.2018   2000            1500
123456      2018    2       01.02.2018    100             100
123456      2018    2       15.02.2018    900             500

******************************************************************************************/

WITH 
A AS
(
SELECT 
ROW_NUMBER() OVER (ORDER BY RECORD_DATE) AS ROWNUMBER_V,
CLIENT_ID, YEAR, MONTH, RECORD_DAY, ACTUAL_VOLUME
FROM CLIENT_ACCOUNT
ORDER BY RECORD_DATE ASC
), 
B AS
(
SELECT 
ROW_NUMBER() OVER (ORDER BY RECORD_DATE) AS ROWNUMBER_V,
CLIENT_ID, YEAR, MONTH, RECORD_DAY, ACTUAL_VOLUME
FROM CLIENT_ACCOUNT
ORDER BY RECORD_DATE ASC
),
C AS
( 
SELECT A.ROWNUMBER_V, A.CLIENT_ID, A.YEAR, A.MONTH, A.RECORD_DAY, AVG(A.ACTUAL_VOLUME) as CALC_CUM_AVG_VOLUME
FROM A
JOIN B ON A.CLIENT_ID = B.CLIENT_ID AND A.YEAR = B.YEAR AND A.MONTH = B.MONTH
WHERE A.ORD >= B.ORD
GROUP BY  A.ORD, A.ADMNO, A.CLNTNO, A.YEAR, A.MONTH, A.STICHTAG
ORDER BY A.ORD ASC
)
SELECT A.ROWNUMBER_V, A.CLIENT_ID, A.YEAR, A.MONTH, A.RECORD_DAY, A.ACTUAL_VOLUME, C.CALC_CUM_AVG_VOLUME
FROM A
LEFT JOIN C on A.CLIENT_ID = C.CLIENT_ID AND A.YEAR = C.YEAR AND A.MONTH = C.MONTH and A.A.RECORD_DAY = C.A.RECORD_DAY
;
