WITH
default_key_rows as (
SELECT distinct SECURITY_CODE,
RECORD_SOURCE
FROM PORTFOLIO_TRACKING.et_MART_PORTFOLIO.DIM_SECURITY
WHERE SECURITY_CODE = '-1'
and RECORD_SOURCE = 'Missing'
),
validation_errors as (
SELECT '-1' as SECURITY_CODE,
'Missing' as RECORD_SOURCE
EXCEPT
SELECT SECURITY_CODE, RECORD_SOURCE
FROM default_key_rows
)
SELECT * FROM default_key_rows