module API
  module V1
    module Discounts
      class CartDiscounts < Grape::API
        resource :cart_discounts do
          desc 'Get all discounts'

          get do
            Discount.where(item_id: nil)
          end

          desc 'Create discount'

          params do
            requires :type, type: Integer, values: Discount.discount_types, desc: 'Discount type 0 => Flat Rate, Percentage => 1'
            requires :discount, type: Float, desc: 'Actual discount'
            requires :operator, type: Integer, values: Discount.operators, desc: 'Operations like equal => 0, greater_than => 1, greater_than_equal => 2, less_than => 3, less_than_equal => 4'
            requires :count, type: Integer, desc: 'Discount on count'
          end

          post do
            discount = Discount.create(
              discount_type: params[:type],
              discount: params[:discount],
              count: params[:count],
              operator: params[:operator]
            )
            if discount.save
              discount
            else
              discount.errors.messages
            end
          end

          desc 'Update a discount'
          params do
            optional :type, type: Integer, values: Discount.discount_types, desc: 'Discount type 0 => Flat Rate, Percentage => 1'
            optional :discount, type: Float, desc: 'Actual discount'
            optional :operator, type: Integer, values: Discount.operators, desc: 'Operations like equal => 0, greater_than => 1, greater_than_equal => 2, less_than => 3, less_than_equal => 4'
            optional :count, type: Integer, desc: 'Discount on count'
          end

          put ':id' do
            discount = Discount.find_by(id: params[:id])
            error!('Discounts not found', 404) unless discount

            discount.update(params)
          end

          desc 'Get a discount'

          get ':id' do
            discount = Discount.find_by(id: params[:id])
            error!('Discount nots found', 404) unless discount

            discount
          end

          desc 'Delete discount'

          delete ':id' do
            discount = Discount.find_by(id: params[:id])
            error!('Discount not founds', 404) unless discount

            discount.destroy
          end
        end
      end
    end
  end
end
