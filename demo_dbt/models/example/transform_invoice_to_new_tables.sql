-- {{ config(materialized='table') }}
{{ config(order_by='(date)', engine='MergeTree()', materialized='incremental', unique_key='date') }}

with invoice as (
    SELECT invoice_number, "date"
    FROM {{ source('public', 'invoices') }}
),

final as (
    select * from invoice
)

select * from final

{% if is_incremental() %}

-- this filter will only be applied on an incremental run
where date > (select max(date) from {{ this }})

{% endif %}