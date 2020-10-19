class CreateDiscountRules < ActiveRecord::Migration[5.2]
  def change
    create_table :discount_rules do |t|
      t.string :symbol
      t.string :rule
      t.float :rate
      t.belongs_to :discount

      t.timestamps
    end
  end
end
