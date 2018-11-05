# sql_hacks

monthly_average_cummulated_values.sql

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
