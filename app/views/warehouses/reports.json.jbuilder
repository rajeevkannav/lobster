json.array! @warehouse.stockpiles do |stockpile|
    json.product_id stockpile.product_id
    json.name stockpile.product.name
    json.available stockpile.available
    json.reserved stockpile.reserved
end