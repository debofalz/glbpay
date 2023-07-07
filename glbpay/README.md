
<h1>Part 1 </h1>
<h3> Preliminary Analysis </h3>

<h4>Source Dataset– </h4>
acceptance_report – Count :5430 </br>
chargeback_report – Count: 5430
</br>
</br>
<b>Time range </b> - Data is from January 2019 to June 2019
external_ref serves as a unique key on both tables
</br> </br>
All external_ref on the acceptance_report can be found in the chargeback_report.
</br> </br>
ref is also unique on the acceptance_report table

</br> </br>
6 Distinct countries exist with 5 different currencies.
The US and AE (which I guess is Arab Emirates) share the same currency according to the data set
</br>
I noticed rates changed across different transactions, which makes sense, as rates are time sensitive.



## Summary of Model Architecture
Stage -> Intermediate -> Mart
Stage – contains data from the source (which is a Bigquery for this assessment). Datasets are stored as views
Intermediate – contains the model used to unpack the rates(JSON) and set each transaction amount to its USD equivalent
Mart – contains the production ready finalized model to the data analyst.
Each subfolder contains model definitions

## Lineage Graphs
![image](https://github.com/debofalz/glbpay/assets/12761971/c5a4287d-5239-4e0f-8f7d-50c525e5cfb9)

## Tips around macros, data validation and documentation
Macros – My dbt project does not contain any macros although they were 2 opportunities to do so.
</br>(a)	Dynamically unpacking the JSON, and set the currency to be the key column. Built it but I was erroring out plus Bigquery forces you to use string literals. I left it as not to waste time. But I know there is an opportunity there as it ensures It is not hardcoded the way it is now with “CASE WHEN” and is built to future proof future additions
</br>
</br>(b)	Set unique code – I avoided this because external ref was unique despite all the joins and so no need to implement this


## Data Validation
Data was validated for some columns using dbt tests to assert for uniqueness, completeness and relational integrity.

## Documentation -
Documentation was done using the __sources.yml files in each layer.  They provide information on the models in their folder.
