module Discounts
  module Services
    class CartDiscount < Base
      def initialize(cart:, cart_price:)
        @cart_price = cart_price
        super(cart: cart)
      end

      private

      def discount
        calculate_cart_discount
        updated_cart_price
      end

      def updated_cart_price
        @updated_cart_price ||= @cart_price -= @discounted_price
      end

      def calculate_cart_discount
        return @discount_price = 0 unless cart_discount

        case cart_discount.discount_type
        when 'flat_rate'
          flat_discount
        when 'percentage'
          percentage_discount
        else
          nil
        end
      end

      def flat_discount
        @discounted_price += cart_discount.discount
      end

      def percentage_discount
        @discounted_price += percent_discount(@cart_price, cart_discount.discount)
      end

      def cart_discount
        @cart_discount ||= Discount.where("item_id is NULL and count <= ?", @cart_price).order('count desc').first
      end
    end
  end
end
