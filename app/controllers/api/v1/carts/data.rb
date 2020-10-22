module API
  module V1
    module Carts
      class Data < Grape::API
        helpers do
          def cart_price

          end
        end
        resource :carts do

          desc 'Create cart'

          params do
            optional :items, type: JSON
          end

          post do
            cart = Cart.new
            params[:items][:items].each do |item_id|
              cart.items << Item.find_by(id: item_id)
            end
            cart_price
            error!(cart.errors.messages, 400) unless cart.save

            cart
          end
        end
      end
    end
  end
end
