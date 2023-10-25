
{% snapshot SNAP_COUNTRIES %}
{{
    config(
            unique_key= 'COUNTRY_HKEY',
            strategy='check',
            check_cols=['COUNTRY_HDIFF'],
           target_schema='SNAPSHOTS'
)
}}
select * from {{ ref('STG_COUNTRIES') }}
{% endsnapshot %} 