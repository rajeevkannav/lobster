# README

#### Prerequisites

 * Rails 5.2.0
 * ruby 2.4.2p198 (2017-09-14 revision 59899) [x86_64-darwin15]
 * Sqilte3 3.16.2 for development
 * OSx EL Captain 10.11.4 (Used as development machine)


#### Considerations

1. Warehouse API 
    * CRUD
    * activity kind_of (add, remove, reserve, ship)
    * adjustments
    * reports

2. Product API 
    * CRUD


#### API-Requests 

Working Insomnia Rest Client JSON is available at the root folder. that could be exported into Insomnia Rest Client to run api(s).

###### Inventory API

Warehouse Add Inventory

```CURL
curl --request POST \
  --url http://localhost:3000/warehouses/<warehouse_id>/activity \
  --header 'content-type: application/json' \
  --data '{
	"quantity": <quantity>, 
	"kind": "add", 
	"product_id": <product_id>
}'
```

Warehouse Remove Inventory

```CURL
curl --request POST \
  --url http://localhost:3000/warehouses/<warehouse_id>/activity \
  --header 'content-type: application/json' \
  --data '{
	"quantity": <quantity>, 
	"kind": "remove", 
	"product_id": <product_id>
}'
```

Warehouse Reserve Inventory

```CURL
curl --request POST \
  --url http://localhost:3000/warehouses/<warehouse_id>/activity \
  --header 'content-type: application/json' \
  --data '{
	"quantity": <quantity>, 
	"kind": "remove", 
	"product_id": <product_id>
}'
```

Warehouse Ship Inventory

```CURL
curl --request POST \
  --url http://localhost:3000/warehouses/<warehouse_id>/activity \
  --header 'content-type: application/json' \
  --data '{
	"quantity": <quantity>, 
	"kind": "remove", 
	"product_id": <product_id>
}'
```

Warehouse Inventory Adjustments

```CURL
curl --request POST \
  --url http://localhost:3000/warehouses/<warehouse_id>/adjustments \
  --header 'content-type: application/json' \
  --data '{
	"quantity": <quantity>, 
	"kind": "ship", 
	"product_id": <product_id>,
	"to_warehouse_id": <to_warehouse_id>
}'
```

Warehouse Inventory Reports

```CURL
curl --request GET \
  --url http://localhost:3000/warehouses/<warehouse_id>/reports
```

#### Tests 

To run tests `rspec .`  
