module Discounts
  module Services
    class GetItemDiscount < Struct.new(:item_id)

      def call
        Discount.where(item_id: item_id).order("count asc")
      end
    end
  end
end
