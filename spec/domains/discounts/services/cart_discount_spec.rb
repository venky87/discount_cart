require 'rails_helper'

RSpec.describe Discounts::Services::CartDiscount do
  let!(:item_a) { create(:item, name: 'A', price: 30)}
  let!(:item_b) { create(:item, name: 'B', price: 20)}
  let!(:item_c) { create(:item, name: 'C', price: 50)}
  let!(:item_d) { create(:item, name: 'D', price: 15)}

  context 'when no discount is applied' do
    let!(:cart) { create(:cart) }
    let!(:cart_item_a) { create(:cart_item, cart: cart, item: item_a) }
    let!(:cart_item_b) { create(:cart_item, cart: cart, item: item_b) }
    let!(:cart_item_c) { create(:cart_item, cart: cart, item: item_c) }
    let!(:discount_a)   { create(:discount, item: nil, count: 150, discount: 20, discount_type: 'flat_rate')}
    let(:service) { described_class.new(cart_price: 100, cart: cart) }
    subject { service.call }

    it 'should return discount price as cart price' do
      subject
      expect(subject).to eq(100)
    end
  end

  context 'when items have bulk buy discount' do
    let!(:cart) { create(:cart) }
    let!(:cart_item_b1) { create(:cart_item, cart: cart, item: item_b) }
    let!(:cart_item_a1) { create(:cart_item, cart: cart, item: item_a) }
    let!(:cart_item_b2) { create(:cart_item, cart: cart, item: item_b) }
    let!(:cart_item_a2) { create(:cart_item, cart: cart, item: item_a) }
    let!(:cart_item_a3) { create(:cart_item, cart: cart, item: item_a) }
    let!(:cart_item_c1) { create(:cart_item, cart: cart, item: item_c) }
    # price => 20 + 30 + 20 + 30 + 30 + 50 = 180
    # Discount => FLat 20 if cart price exceeds 150
    let!(:discount_a)   { create(:discount, item: nil, count: 150, discount: 20, discount_type: 'flat_rate')}
    let(:service) { described_class.new(cart_price: 180, cart: cart) }
    subject { service.call }

    it 'should return discounted price' do
      subject
      expect(subject).to eq(160)
    end
  end
end