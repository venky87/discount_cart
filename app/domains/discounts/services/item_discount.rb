module Discounts
  module Services
    class ItemDiscount < Base

      private
      def discount
        total_items_discount
        updated_cart_price
      end

      def updated_cart_price
        @discounted_price == 0 ? cart_price : @discounted_price
      end

      def total_items_discount
        item_flat_rate_discount
        item_percentage_discount
      end

      def item_flat_rate_discount
        grouped_items.keys.each do |item_id|
          item = Item.find_by(id: item_id)
          discount = item.discounts.where(
            'discount_type = ? and count <= ?',
            Discount.discount_types['flat_rate'],
            grouped_items[item_id].count
          ).order('count desc').first

          if discount.nil?
            @discounted_price += item.price
            next
          end

          @discounted_price += discount.discount
        end
      end

      def item_percentage_discount
        grouped_items.keys.each do |item_id|
          item = Item.find_by(id: item_id)
          discount = item.discounts.where(
            'discount_type = ? and count <= ?',
            Discount.discount_types['percentage'],
            grouped_items[item_id].count
          ).order('count desc').first
          next unless discount

          @discounted_price += percent_discount(item.price, discount.discount)
        end
      end

      def grouped_items
        @grouped_items ||= items.group_by(&:id)
      end
    end
  end
end
