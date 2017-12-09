class ProductCategory < ApplicationRecord
  has_many   :products
  has_many   :children, class_name: "ProductCategory", foreign_key: "parent_product_category_id"
  belongs_to :parent,   class_name: "ProductCategory", foreign_key: "parent_product_category_id"

  accepts_nested_attributes_for :products
end
