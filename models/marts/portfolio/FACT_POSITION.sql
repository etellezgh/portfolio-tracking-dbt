{{ config(schema="MART_PORTFOLIO", materialized="table") }}
select *
from {{ ref("REF_POSITION_ABC_BANK") }}
