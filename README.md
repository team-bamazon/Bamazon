# DB設計

## users table

### password, email << devise

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|furigana|string|null: false|
|address|string||
|language|string||
|points|integer||
|phone_number|string||
|profile|text||
|nickname|string||
|profile_image|string||

### Association
- has_one :cart
- has_many :orders
- has_many :payment_infos
- has_many :wanteds
- has_many :reviews
- has_many :review_comments


## products table

|Column|Type|Options|
|------|----|-------|
|name|string|index: true, null: false|
|price|float|null: false|
|detail|string||
|stock|integer||
|ammount_sales|integer||
|product_category_id|integer|foreign_key: true|

### Association
- has_many :carts, through: :cart_products
- has_many :wanteds, through: :wanted_products
- has_many :product_images
- has_many :reviews
- belongs_to :product_category


## product_images table

|Column|Type|Options|
|------|----|-------|
|image|string||
|product_id|integer|foreign_key: true|

### Association
- belongs_to :product


## carts table

|Column|Type|Options|
|------|----|-------|
|user_id|integer|foreign_key: true|

### Association
- belongs_to :user
- has_many :products, through: :cart_products


## cart_products table

|Column|Type|Options|
|------|----|-------|
|cart_id|integer|foreign_key: true|
|product_id|integer|foreign_key: true|
|product_count|integer||

### Association
- belongs_to :product
- belongs_to :cart


## orders table

|Column|Type|Options|
|------|----|-------|
|address|string|null: false|
|postal_code|string|null: false|
|phone_number|string|null: false|
|payment_info|string|null: false|
|status|integer|null: false|
|user_id|integer|foreign_key: true|

### Association
- belongs_to :user
- has_many :order_products


## order_products table

|Column|Type|Options|
|------|----|-------|
|order_id|integer|foreign_key: true|
|product_name|string|null: false|
|price|string|null: false|
|product_image|string||
|count|integer|null: false|

### Association
- belongs_to :order


## payment_informations table

|Column|Type|Options|
|------|----|-------|
|user_id|integer|foreign_key: true|

### Association
- belongs_to :user


## wanteds table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|default_flg|integer||
|open_flg|integer||
|user_id|integer|foreign_key: true|

### Association
- belongs_to :user
- has_many :products, through: :wanted_products


## wanted_products table

|Column|Type|Options|
|------|----|-------|
|wanted_id|integer|foreign_key: true|
|product_id|integer|foreign_key: true|
|product_count|integer||

### Association
- belongs_to :product
- belongs_to :wanted


## product_categories table

|Column|Type|Options|
|------|----|-------|
|category_name|string||
|parent_product_category_id|integer||

### Association
- has_many :products
- has_many :children, class_name: "ProductCategory", foreign_key: "parent_product_category_id"
- belongs_to :parent, class_name: "ProductCategory", foreign_key: "parent_product_category_id"


## reviews table

|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|body|text|null: false|
|rate|float|null: false|
|user_id|integer|foreign_key: true|
|product_id|integer|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :product
- has_many :review_comments


## likes table

|Column|Type|Options|
|------|----|-------|
|user_id|integer|foreign_key: true|
|review_id|integer|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :review


## dislikes table

|Column|Type|Options|
|------|----|-------|
|user_id|integer|foreign_key: true|
|review_id|integer|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :review


## review_comments table

|Column|Type|Options|
|------|----|-------|
|body|text|null: false|
|user_id|integer|foreign_key: true|
|review_id|integer|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :review
