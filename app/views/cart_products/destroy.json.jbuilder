json.product_name @cart_product.product.name
json.cart_products @cart.cart_products
json.product_id @cart_product.product_id
json.cart_count_sum @cart.cart_count_sum(@cart)
json.cart_price_sum @cart.cart_price_sum(@cart)
json.cart_point_sum @cart.cart_point_sum(@cart)

