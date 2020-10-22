module API
  module V1
    module Carts
      class Data < Grape::API
        helpers do
          def discount_price(cart)
            ::Discounts::Services::GetDiscountedPrice.new(cart: cart).call
          end

          def cart_price(cart)
            @cart_price ||= cart.items.inject(0) { |sum, item| sum + item.price }
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
            error!(cart.errors.messages, 400) unless cart.save

            { items: cart.items, cart_price: cart_price(cart), discounted_price: discount_price(cart) }
          end
        end
      end
    end
  end
end
