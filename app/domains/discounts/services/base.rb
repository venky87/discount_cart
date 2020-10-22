module Discounts
  module Services
    class Base
      def initialize(cart:)
        @cart = cart
        @discounted_price = 0
      end

      attr_reader :successor, :cart

      def call
        discount
      end

      def total_price
        updated_cart_price
      end

      def cart_price
        @cart_price ||= items.inject(0) { |sum, item| sum + item.price }
      end

      private

      def items
        @items ||= cart.items
      end

      def percent_discount(cost, percentage)
        (cost.to_f / percentage * 100.0).round(2)
      end

      def discount
        raise NotImplementedError, 'Each handler should respond to calculate_discount methods'
      end
    end
  end
end
