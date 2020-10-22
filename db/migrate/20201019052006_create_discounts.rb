class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.integer    :discount_type
      t.float      :discount
      t.integer    :count
      t.integer    :operator
      t.belongs_to :item, default: nil

      t.timestamps
    end
  end
end
