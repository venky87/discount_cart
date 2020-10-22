class ChangeItemsIdItemId < ActiveRecord::Migration[5.2]
  def change
    rename_column :cart_items, :items_id, :item_id
  end
end
