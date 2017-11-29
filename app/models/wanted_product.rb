class WantedProduct < ApplicationRecord
  belongs_to :product
  belongs_to :wanted
end
