module Discounts
  module Services
    class GetDiscountedPrice
      def initialize(cart:)
        @cart = cart
      end

      def call
        item_discounts = ItemDiscount.new(cart: @cart).call
        CartDiscount.new(cart: @cart, cart_price: item_discounts).call
      end
    end
  end
end