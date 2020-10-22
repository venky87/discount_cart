require 'rails_helper'

RSpec.describe Discounts::Services::GetDiscountedPrice do
  let!(:item_a) { create(:item, name: 'A', price: 30)}
  let!(:item_b) { create(:item, name: 'B', price: 20)}
  let!(:item_c) { create(:item, name: 'C', price: 50)}
  let!(:item_d) { create(:item, name: 'D', price: 15)}
  let!(:discount_a)   { create(:discount, item: item_a, count: 3, discount: 75)}
  let!(:discount_b)   { create(:discount, item: item_b, count: 2, discount: 35)}
  let!(:discount)     { create(:discount, item: nil, count: 150, discount: 20, discount_type: 'flat_rate')}

  context 'when no discount is applied' do
    let!(:cart) { create(:cart) }
    let!(:cart_item_a) { create(:cart_item, cart: cart, item: item_a) }
    let!(:cart_item_b) { create(:cart_item, cart: cart, item: item_b) }
    let!(:cart_item_c) { create(:cart_item, cart: cart, item: item_c) }
    let(:service) { described_class.new(cart: cart) }
    subject { service.call }

    it 'should return discount price as cart price' do
      subject
      expect(subject).to eq(100)
    end
  end

  context 'when items have bulk buy discount and cart discount' do
    let!(:cart) { create(:cart) }
    let!(:cart_item_c1) { create(:cart_item, cart: cart, item: item_c) }
    let!(:cart_item_b1) { create(:cart_item, cart: cart, item: item_b) }
    let!(:cart_item_a1) { create(:cart_item, cart: cart, item: item_a) }
    let!(:cart_item_a2) { create(:cart_item, cart: cart, item: item_a) }
    let!(:cart_item_d1) { create(:cart_item, cart: cart, item: item_d) }
    let!(:cart_item_a3) { create(:cart_item, cart: cart, item: item_a) }
    let!(:cart_item_b2) { create(:cart_item, cart: cart, item: item_b) }

    let(:service) { described_class.new(cart: cart) }
    subject { service.call }

    it 'should return item and cart discounted price' do
      subject
      expect(subject).to eq(155)
    end
  end
end