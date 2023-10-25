{{ config(materialized='ephemeral') }}

WITH
src_data as (
        SELECT
        Name,ID,Country,City,Zone,Delta,DST_period,Open,Close,Lunch,Open_UTC,Close_UTC,Lunch_UTC,
        LOAD_TS as LOAD_TS -- TIMESTAMP_NTZ
        , 'SEED.EXCHANGE' as RECORD_SOURCE
        FROM {{ source('seeds', 'EXCHANGE') }}
),
hashed as (
        SELECT
        concat_ws('|', ID) as EXCHANGE_HKEY
        , concat_ws('|', Name,ID,Country,City,Zone,Delta,COALESCE(DST_period,'N/A'),Open,Close,Lunch,Open_UTC,Close_UTC,Lunch_UTC )
        as EXCHANGE_HDIFF
        , * EXCLUDE LOAD_TS
        , LOAD_TS as LOAD_TS_UTC
        FROM src_data
)
SELECT * FROM hashed