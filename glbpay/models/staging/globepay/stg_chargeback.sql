with chargeback as
( Select
      external_ref
      , status
      , source
      , chargeback
  from {{ source('source', 'chargeback_report') }}
)

Select * from chargeback
