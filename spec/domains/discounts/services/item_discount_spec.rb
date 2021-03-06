require 'rails_helper'

RSpec.describe Discounts::Services::ItemDiscount do
  let!(:item_a) { create(:item, name: 'A', price: 30)}
  let!(:item_b) { create(:item, name: 'B', price: 20)}
  let!(:item_c) { create(:item, name: 'C', price: 50)}
  let!(:item_d) { create(:item, name: 'D', price: 15)}

  context 'when no discount is applied' do
    let!(:cart) { create(:cart) }
    let!(:cart_item_a) { create(:cart_item, cart: cart, item: item_a) }
    let!(:cart_item_b) { create(:cart_item, cart: cart, item: item_b) }
    let!(:cart_item_c) { create(:cart_item, cart: cart, item: item_c) }
    let!(:discount_a)   { create(:discount, item: item_a, count: 3, discount: 75)}
    let!(:discount_b)   { create(:discount, item: item_b, count: 2, discount: 35)}
    let(:service) { described_class.new(cart: cart) }
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
    let!(:discount_a)   { create(:discount, item: item_a, count: 3, discount: 75)}
    let!(:discount_b)   { create(:discount, item: item_b, count: 2, discount: 35)}
    let(:service) { described_class.new(cart: cart) }
    subject { service.call }

    it 'should return discounted price' do
      subject
      expect(subject).to eq(110)
    end
  end
end
