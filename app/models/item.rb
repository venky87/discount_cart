class Item < ApplicationRecord
  has_many :discounts, as: :discountable
end
