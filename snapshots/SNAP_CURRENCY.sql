
{% snapshot SNAP_CURRENCY %}
{{
    config(
            unique_key= 'CURRENCY_HKEY',
            strategy='check',
            check_cols=['CURRENCY_HDIFF'],
           target_schema='SNAPSHOTS'
)
}}
select * from {{ ref('STG_CURRENCY') }}
{% endsnapshot %} 