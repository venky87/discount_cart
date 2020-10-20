# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_19_102448) do

  create_table "cart_items", force: :cascade do |t|
    t.integer "items_id"
    t.integer "cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["items_id"], name: "index_cart_items_on_items_id"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "discount_rules", force: :cascade do |t|
    t.string "symbol"
    t.string "rule"
    t.float "rate"
    t.integer "discount_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discount_id"], name: "index_discount_rules_on_discount_id"
  end

  create_table "discounts", force: :cascade do |t|
    t.integer "discount_type"
    t.string "discountable_type"
    t.integer "discountable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discountable_type", "discountable_id"], name: "index_discounts_on_discountable_type_and_discountable_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
