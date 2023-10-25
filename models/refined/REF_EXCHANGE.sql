WITH
current_from_snapshot as (
{{ current_from_snapshot(
snsh_ref=ref('SNAP_EXCHANGE')
,output_load_ts =false) }}
)
SELECT
*
FROM current_from_snapshot