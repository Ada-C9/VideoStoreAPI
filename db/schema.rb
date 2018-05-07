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

ActiveRecord::Schema.define(version: 20180507231810) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.string "phone"
    t.integer "movies_checked_out_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "registered_at"
  end

  create_table "customers_movies_joins", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "movie_id"
    t.index ["customer_id"], name: "index_customers_movies_joins_on_customer_id"
    t.index ["movie_id"], name: "index_customers_movies_joins_on_movie_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "overview"
    t.date "release_date"
    t.integer "inventory"
    t.integer "available_inventory"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
