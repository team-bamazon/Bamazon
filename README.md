# DB設計

## users table

### password, email << devise

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|furigana|string||
|address|string||
|postal_code|string||
|language|string||
|points|integer||
|phone_number|string||
|profile|text||
|nickname|string||
|profile_image|string||

### Association
- has_one :cart
- has_many :orders
- has_many :payment_informations
- has_many :wanteds
- has_many :reviews
- has_many :review_comments
- has_many :likes
- has_many :dislikes

## products table

|Column|Type|Options|
|------|----|-------|
|name|string|index: true, null: false|
|price|float|null: false|
|detail|string||
|stock|integer||
|amount_sales|integer||
|product_category_id|integer||

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
|address|string||
|postal_code|string||
|phone_number|string||
|card_name|string||
|card_number|integer||
|month|integer||
|year|integer||
|security_code|integer||
|card_company|string||
|status|integer||
|user_id|integer|foreign_key: true|

### Association
- belongs_to :user
- has_many :order_products


## order_products table

|Column|Type|Options|
|------|----|-------|
|order_id|integer|foreign_key: true|
|product_name|string||
|price|float||
|product_image|string||
|count|integer||

### Association
- belongs_to :order


## payment_informations table

|Column|Type|Options|
|------|----|-------|
|user_id|integer|foreign_key: true|
|card_name|string||
|card_number|integer||
|month|integer||
|year|integer||
|security_code|integer||
|card_company|string||

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
