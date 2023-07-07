with acceptance
as
(
Select
external_ref
, ref
, created_date
, state
, country
, amount_usd
from {{ref('int_acceptance_rate_unnested')}}
)


, chargeback
as
(
  Select
  external_ref
  , chargeback
  from
  {{ref('stg_chargeback')}}
)

Select
ac.external_ref
, ac.state
, ac.created_date
, ac.country
, ac.amount_usd
, ch.chargeback
from
acceptance ac
left join
chargeback ch
on ac.external_ref = ch.external_ref
