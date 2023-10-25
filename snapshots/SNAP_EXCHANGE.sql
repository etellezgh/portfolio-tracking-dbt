{% snapshot SNAP_EXCHANGE %}
{{
    config(
            unique_key= 'EXCHANGE_HKEY',
            strategy='check',
            check_cols=['EXCHANGE_HDIFF'],
           target_schema='SNAPSHOTS'
)
}}
select * from {{ ref('STG_EXCHANGE') }}
{% endsnapshot %} 