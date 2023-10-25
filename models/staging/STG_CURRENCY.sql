{{ config(materialized='ephemeral') }}

WITH
src_data as (
        SELECT
        AlphabeticCode,NumericCode,DecimalDigits,CurrencyName,Locations,
        LOAD_TS as LOAD_TS -- TIMESTAMP_NTZ
        , 'SEED.CURRENCY' as RECORD_SOURCE
        FROM {{ source('seeds', 'CURRENCY') }}
),
hashed as (
        SELECT
        concat_ws('|', AlphabeticCode) as CURRENCY_HKEY
        , concat_ws('|', NumericCode,DecimalDigits,CurrencyName,Locations )
        as CURRENCY_HDIFF
        , * EXCLUDE LOAD_TS
        , LOAD_TS as LOAD_TS_UTC
        FROM src_data
)
SELECT * FROM hashed