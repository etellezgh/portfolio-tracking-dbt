{{ config(schema="MART_PORTFOLIO", materialized="table") }}
SELECT * FROM {{ ref('REF_EXCHANGE') }}