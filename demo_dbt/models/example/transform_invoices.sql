with invoice as (
    SELECT invoice_number, "date"
    FROM {{ source('public', 'invoices') }}
),

final as (
    select * from invoice
)

select * from final