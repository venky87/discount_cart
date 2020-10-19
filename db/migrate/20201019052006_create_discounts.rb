class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.integer :discount_type
      t.references :discountable, polymorphic: true

      t.timestamps
    end
  end
end
