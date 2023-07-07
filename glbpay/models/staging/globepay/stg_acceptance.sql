with acceptance as
( Select
        external_ref
        , status
        , source
        , ref
        -- dates
        , date(date_time) as created_date

        -- timestamps
        , timestamp(date_time) as created_time
        , state
        , cvv_provided
        , amount
        , country
        , currency
        , rates
   from {{ source('source', 'acceptance_report') }}
)

Select *
from acceptance
