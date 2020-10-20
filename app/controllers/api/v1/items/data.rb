module API
  module V1
    module Items
      class Data < Grape::API
        resource :items do

          desc "Get all items"

          get do
            Item.all
          end

          desc "Create Item"

          params do
            requires "name", type: String, desc: "Item name"
            requires "price", type: Float, desc: "Item Price"
          end

          post do
            Item.create(name: params[:name], price: params[:price])
          end

          desc "Update an Item"

          params do
            optional "name", type: String, desc: "Item name"
            optional "price", type: Float, desc: "Item Price"
          end

          put ":id" do
            item = Item.find_by(id: params[:id])
            error!("Item not found", 404) unless item

            item.update(params)
            item
          end

          desc "Get an Item"

          get ":id" do
            item = Item.find_by(id: params[:id])
            error!("Item not found", 404) unless item

            item
          end

          desc "Delete an Item"

          delete ":id" do
            item = Item.find_by(id: params[:id])
            error!("Item not found", 404) unless item

            item.delete
          end

        end
      end
    end
  end
end
