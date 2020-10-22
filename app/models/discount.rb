class Discount < ApplicationRecord
  enum discount_type: %w[flat_rate percentage]
  enum operator:      %w[equal gt gte lt lte]
  belongs_to :item, optional: true
  validates_uniqueness_of :count, scope: :item, message: 'Discount for the item with same count is present'
end
