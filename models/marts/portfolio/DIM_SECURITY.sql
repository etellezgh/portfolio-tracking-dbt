{{ config(schema="MART_PORTFOLIO", materialized="table") }}
SELECT * FROM {{ ref('REF_ABC_BANK_SECURITY_INFO') }}