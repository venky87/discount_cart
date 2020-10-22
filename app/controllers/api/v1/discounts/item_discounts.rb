module API
  module V1
    module Discounts
      class ItemDiscounts < Grape::API
        namespace 'items/:id' do
          resource :item_discounts do
            desc 'Get all discounts for the item'

            get do
              item = Item.find_by(id: params[:id])
              error!('Item not found', 404) unless item

              item.discounts
            end

            desc 'Create discount for the item'

            params do
              requires :discount_type, type: Integer, values: Discount.discount_types, desc: 'Discount type 0 => Flat Rate, Percentage => 1'
              requires :discount, type: Float, desc: 'Actual discount'
              requires :operator, type: Integer, values: Discount.operators, desc: 'Operations like equal => 0, greater_than => 1, greater_than_equal => 2, less_than => 3, less_than_equal => 4'
              requires :count, type: Integer, desc: 'Discount on count'
            end

            post do
              item = Item.find_by(id: params[:id])
              error!('Item not found', 404) unless item

              discount = item.discounts.new(
                discount_type: params[:type],
                discount: params[:discount],
                count: params[:count],
                operator: params[:operator]
              )

              error!(discount.errors.messages, 400) unless discount.save

              discount
            end
          end

          desc 'Update a discount for the Item'
          params do
            optional :discount_type, type: Integer, values: Discount.discount_types, desc: 'Discount type 0 => Flat Rate, Percentage => 1'
            optional :discount, type: Float, desc: 'Actual discount'
            optional :operator, type: Integer, values: Discount.operators, desc: 'Operations like equal => 0, greater_than => 1, greater_than_equal => 2, less_than => 3, less_than_equal => 4'
            optional :count, type: Integer, desc: 'Discount on count'
          end

          put ':discount_id' do
            item = Item.find_by(id: params[:id])
            error!('Item not found', 404) unless item

            discount = item.discounts.find_by(id: params[:discount_id])
            error!('Discount for the item not found', 404) unless discount

            discount.assign_attributes(
              {
                discount_type: params[:type],
                discount: params[:discount],
                count: params[:count],
                operator: params[:operator]
              }
            )

            error!(discount.errors.messages, 400) unless discount.save

            discount
          end

          desc 'Get a discount for the item'

          get ':discount_id' do
            item = Item.find_by(id: params[:id])
            error!('Item not found', 404) unless item

            discount = item.discounts.find_by(id: params[:discount_id])
            error!('Discount for the item not found', 404) unless discount

            discount
          end

          desc 'Delete discount'

          delete ':discount_id' do
            item = Item.find_by(id: params[:id])
            error!('Item not found', 404) unless item

            discount = item.discounts.find_by(id: params[:discount_id])
            error!('Discount for the item not found', 404) unless discount

            discount.destroy
          end
        end
      end
    end
  end
end
