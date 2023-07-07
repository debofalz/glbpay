with acceptance_with_exchange_rate as
(
Select
        external_ref
        , status
        , source
        , ref
        , created_date
        , created_time
        , state
        , cvv_provided
        , amount
        , country
        , currency
        , rates
        ,
          cast( case when currency = 'USD' then json_extract(rates, '$.USD')
              when currency = 'CAD' then json_extract(rates, '$.CAD')
              when currency = 'EUR' then json_extract(rates, '$.EUR')
              when currency = 'MXN' then json_extract(rates, '$.MXN')
              when currency = 'AUD' then json_extract(rates, '$.AUD')
              when currency = 'GBP' then json_extract(rates, '$.GBP')
              when currency = 'SGD' then json_extract(rates, '$.SGD')  end
             as Numeric ) as exchange_rate
from {{ref('stg_acceptance')}}
)


, acceptance_usd as
(
  Select
  external_ref
  , status
  , source
  , ref
  , created_date
  , created_time
  , state
  , cvv_provided
  , amount as amount_lc --this is amount in local currency
  , country
  , currency
  , rates
  , cast (amount * exchange_rate as Numeric) as amount_usd --this is the amount in usd
  from
  acceptance_with_exchange_rate
)


Select * from acceptance_usd
