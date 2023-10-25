{{ config(materialized='ephemeral') }}

WITH
src_data as (
        SELECT
        country_name,
        country_code_2_letter,
        country_code_3_letter,
        country_code_numeric,
        iso_3166_2,
        region,
        sub_region,
        intermediate_region,
        region_code,
        sub_region_code,
        intermediate_region_code,
        LOAD_TS as LOAD_TS -- TIMESTAMP_NTZ
        , 'SEED.COUNTRIES' as RECORD_SOURCE
        FROM {{ source('seeds', 'COUNTRIES') }}
),
hashed as (
        SELECT
        concat_ws('|', country_code_3_letter) as COUNTRY_HKEY
        , concat_ws('|', country_name,
        country_code_2_letter,
        country_code_numeric,
        iso_3166_2,
        COALESCE(region,'N/A'),
         COALESCE(sub_region,'N/A'),
         COALESCE(region_code,0),
         COALESCE(sub_region_code,0)
    )
        as COUNTRY_HDIFF
        , * EXCLUDE LOAD_TS
        , LOAD_TS as LOAD_TS_UTC
        FROM src_data
)
SELECT * FROM hashed