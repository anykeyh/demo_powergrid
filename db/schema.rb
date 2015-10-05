# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151002160943) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actors", force: :cascade do |t|
    t.string   "first_name", limit: 45,                                 null: false
    t.string   "last_name",  limit: 45,                                 null: false
    t.datetime "updated_at",            default: '2015-09-26 09:49:52', null: false
    t.datetime "created_at",            default: '2015-09-26 09:49:53', null: false
  end

  add_index "actors", ["created_at"], name: "index_actors_on_created_at", using: :btree
  add_index "actors", ["last_name"], name: "idx_actor_last_name", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.string   "address",     limit: 50,                                 null: false
    t.string   "address2",    limit: 50
    t.string   "district",    limit: 20,                                 null: false
    t.integer  "city_id",     limit: 2,                                  null: false
    t.string   "postal_code", limit: 10
    t.string   "phone",       limit: 20,                                 null: false
    t.datetime "updated_at",             default: '2015-09-26 09:49:52', null: false
    t.datetime "created_at",             default: '2015-09-26 09:49:53', null: false
  end

  add_index "addresses", ["city_id"], name: "idx_fk_city_id", using: :btree
  add_index "addresses", ["created_at"], name: "index_addresses_on_created_at", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 25,                                 null: false
    t.datetime "updated_at",            default: '2015-09-26 09:49:52', null: false
    t.datetime "created_at",            default: '2015-09-26 09:49:53', null: false
  end

  add_index "categories", ["created_at"], name: "index_categories_on_created_at", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "city",       limit: 50,                                 null: false
    t.integer  "country_id", limit: 2,                                  null: false
    t.datetime "updated_at",            default: '2015-09-26 09:49:52', null: false
    t.datetime "created_at",            default: '2015-09-26 09:49:53', null: false
  end

  add_index "cities", ["country_id"], name: "idx_fk_country_id", using: :btree
  add_index "cities", ["created_at"], name: "index_cities_on_created_at", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "country",    limit: 50,                                 null: false
    t.datetime "updated_at",            default: '2015-09-26 09:49:52', null: false
    t.datetime "created_at",            default: '2015-09-26 09:49:53', null: false
  end

  add_index "countries", ["created_at"], name: "index_countries_on_created_at", using: :btree

  create_table "customers", force: :cascade do |t|
    t.integer  "store_id",    limit: 2,                                  null: false
    t.string   "first_name",  limit: 45,                                 null: false
    t.string   "last_name",   limit: 45,                                 null: false
    t.string   "email",       limit: 50
    t.integer  "address_id",  limit: 2,                                  null: false
    t.boolean  "activebool",             default: true,                  null: false
    t.date     "create_date",                                            null: false
    t.datetime "updated_at",             default: '2015-09-26 09:49:52'
    t.integer  "active"
    t.datetime "created_at",             default: '2015-09-26 09:49:53', null: false
  end

  add_index "customers", ["address_id"], name: "idx_fk_address_id", using: :btree
  add_index "customers", ["created_at"], name: "index_customers_on_created_at", using: :btree
  add_index "customers", ["last_name"], name: "idx_last_name", using: :btree
  add_index "customers", ["store_id"], name: "idx_fk_store_id", using: :btree

  create_table "film_actors", id: false, force: :cascade do |t|
    t.integer  "actor_id",   limit: 2,                                 null: false
    t.integer  "film_id",    limit: 2,                                 null: false
    t.datetime "updated_at",           default: '2015-09-26 09:49:52', null: false
    t.datetime "created_at",           default: '2015-09-26 09:49:53', null: false
  end

  add_index "film_actors", ["created_at"], name: "index_film_actors_on_created_at", using: :btree
  add_index "film_actors", ["film_id"], name: "idx_fk_film_id", using: :btree

  create_table "film_categories", id: false, force: :cascade do |t|
    t.integer  "film_id",     limit: 2,                                 null: false
    t.integer  "category_id", limit: 2,                                 null: false
    t.datetime "updated_at",            default: '2015-09-26 09:49:52', null: false
    t.datetime "created_at",            default: '2015-09-26 09:49:53', null: false
  end

  add_index "film_categories", ["created_at"], name: "index_film_categories_on_created_at", using: :btree

  create_table "films", force: :cascade do |t|
    t.string   "title",                                                                        null: false
    t.text     "description"
    t.integer  "release_year"
    t.integer  "language_id",                                                                  null: false
    t.integer  "original_language_id"
    t.integer  "rental_duration",                              default: 3,                     null: false
    t.decimal  "rental_rate",          precision: 5, scale: 2, default: 4.99,                  null: false
    t.integer  "length"
    t.decimal  "replacement_cost",     precision: 5, scale: 2, default: 19.99,                 null: false
    t.string   "rating",                                       default: "G"
    t.datetime "updated_at",                                                                   null: false
    t.text     "special_features",                                                                          array: true
    t.tsvector "fulltext",                                                                     null: false
    t.datetime "created_at",                                   default: '2015-09-26 09:49:53', null: false
  end

  add_index "films", ["created_at"], name: "index_films_on_created_at", using: :btree

  create_table "inventories", force: :cascade do |t|
    t.integer  "film_id",    limit: 2,                                 null: false
    t.integer  "store_id",   limit: 2,                                 null: false
    t.datetime "updated_at",           default: '2015-09-26 09:49:52', null: false
    t.datetime "created_at",           default: '2015-09-26 09:49:53', null: false
  end

  add_index "inventories", ["created_at"], name: "index_inventories_on_created_at", using: :btree
  add_index "inventories", ["store_id", "film_id"], name: "idx_store_id_film_id", using: :btree

  create_table "languages", force: :cascade do |t|
    t.string   "name",       limit: 20,                                 null: false
    t.datetime "updated_at",            default: '2015-09-26 09:49:52', null: false
    t.datetime "created_at",            default: '2015-09-26 09:49:53', null: false
  end

  add_index "languages", ["created_at"], name: "index_languages_on_created_at", using: :btree

  create_table "payment_p2007_01s", id: false, force: :cascade do |t|
    t.integer  "id",                                             default: 0,                     null: false
    t.integer  "customer_id",  limit: 2,                                                         null: false
    t.integer  "staff_id",     limit: 2,                                                         null: false
    t.integer  "rental_id",                                                                      null: false
    t.decimal  "amount",                 precision: 5, scale: 2,                                 null: false
    t.datetime "payment_date",                                                                   null: false
    t.datetime "updated_at",                                     default: '2015-09-26 09:49:53', null: false
    t.datetime "created_at",                                     default: '2015-09-26 09:49:53', null: false
  end

  add_index "payment_p2007_01s", ["created_at"], name: "index_payment_p2007_01s_on_created_at", using: :btree
  add_index "payment_p2007_01s", ["customer_id"], name: "idx_fk_payment_p2007_01_customer_id", using: :btree
  add_index "payment_p2007_01s", ["staff_id"], name: "idx_fk_payment_p2007_01_staff_id", using: :btree
  add_index "payment_p2007_01s", ["updated_at"], name: "index_payment_p2007_01s_on_updated_at", using: :btree

  create_table "payment_p2007_02s", id: false, force: :cascade do |t|
    t.integer  "id",                                             default: 0,                     null: false
    t.integer  "customer_id",  limit: 2,                                                         null: false
    t.integer  "staff_id",     limit: 2,                                                         null: false
    t.integer  "rental_id",                                                                      null: false
    t.decimal  "amount",                 precision: 5, scale: 2,                                 null: false
    t.datetime "payment_date",                                                                   null: false
    t.datetime "updated_at",                                     default: '2015-09-26 09:49:53', null: false
    t.datetime "created_at",                                     default: '2015-09-26 09:49:53', null: false
  end

  add_index "payment_p2007_02s", ["created_at"], name: "index_payment_p2007_02s_on_created_at", using: :btree
  add_index "payment_p2007_02s", ["customer_id"], name: "idx_fk_payment_p2007_02_customer_id", using: :btree
  add_index "payment_p2007_02s", ["staff_id"], name: "idx_fk_payment_p2007_02_staff_id", using: :btree
  add_index "payment_p2007_02s", ["updated_at"], name: "index_payment_p2007_02s_on_updated_at", using: :btree

  create_table "payment_p2007_03s", id: false, force: :cascade do |t|
    t.integer  "id",                                             default: 0,                     null: false
    t.integer  "customer_id",  limit: 2,                                                         null: false
    t.integer  "staff_id",     limit: 2,                                                         null: false
    t.integer  "rental_id",                                                                      null: false
    t.decimal  "amount",                 precision: 5, scale: 2,                                 null: false
    t.datetime "payment_date",                                                                   null: false
    t.datetime "updated_at",                                     default: '2015-09-26 09:49:53', null: false
    t.datetime "created_at",                                     default: '2015-09-26 09:49:53', null: false
  end

  add_index "payment_p2007_03s", ["created_at"], name: "index_payment_p2007_03s_on_created_at", using: :btree
  add_index "payment_p2007_03s", ["customer_id"], name: "idx_fk_payment_p2007_03_customer_id", using: :btree
  add_index "payment_p2007_03s", ["staff_id"], name: "idx_fk_payment_p2007_03_staff_id", using: :btree
  add_index "payment_p2007_03s", ["updated_at"], name: "index_payment_p2007_03s_on_updated_at", using: :btree

  create_table "payment_p2007_04s", id: false, force: :cascade do |t|
    t.integer  "id",                                             default: 0,                     null: false
    t.integer  "customer_id",  limit: 2,                                                         null: false
    t.integer  "staff_id",     limit: 2,                                                         null: false
    t.integer  "rental_id",                                                                      null: false
    t.decimal  "amount",                 precision: 5, scale: 2,                                 null: false
    t.datetime "payment_date",                                                                   null: false
    t.datetime "updated_at",                                     default: '2015-09-26 09:49:53', null: false
    t.datetime "created_at",                                     default: '2015-09-26 09:49:53', null: false
  end

  add_index "payment_p2007_04s", ["created_at"], name: "index_payment_p2007_04s_on_created_at", using: :btree
  add_index "payment_p2007_04s", ["customer_id"], name: "idx_fk_payment_p2007_04_customer_id", using: :btree
  add_index "payment_p2007_04s", ["staff_id"], name: "idx_fk_payment_p2007_04_staff_id", using: :btree
  add_index "payment_p2007_04s", ["updated_at"], name: "index_payment_p2007_04s_on_updated_at", using: :btree

  create_table "payment_p2007_05s", id: false, force: :cascade do |t|
    t.integer  "id",                                             default: 0,                     null: false
    t.integer  "customer_id",  limit: 2,                                                         null: false
    t.integer  "staff_id",     limit: 2,                                                         null: false
    t.integer  "rental_id",                                                                      null: false
    t.decimal  "amount",                 precision: 5, scale: 2,                                 null: false
    t.datetime "payment_date",                                                                   null: false
    t.datetime "updated_at",                                     default: '2015-09-26 09:49:53', null: false
    t.datetime "created_at",                                     default: '2015-09-26 09:49:53', null: false
  end

  add_index "payment_p2007_05s", ["created_at"], name: "index_payment_p2007_05s_on_created_at", using: :btree
  add_index "payment_p2007_05s", ["customer_id"], name: "idx_fk_payment_p2007_05_customer_id", using: :btree
  add_index "payment_p2007_05s", ["staff_id"], name: "idx_fk_payment_p2007_05_staff_id", using: :btree
  add_index "payment_p2007_05s", ["updated_at"], name: "index_payment_p2007_05s_on_updated_at", using: :btree

  create_table "payment_p2007_06s", id: false, force: :cascade do |t|
    t.integer  "id",                                             default: 0,                     null: false
    t.integer  "customer_id",  limit: 2,                                                         null: false
    t.integer  "staff_id",     limit: 2,                                                         null: false
    t.integer  "rental_id",                                                                      null: false
    t.decimal  "amount",                 precision: 5, scale: 2,                                 null: false
    t.datetime "payment_date",                                                                   null: false
    t.datetime "updated_at",                                     default: '2015-09-26 09:49:53', null: false
    t.datetime "created_at",                                     default: '2015-09-26 09:49:53', null: false
  end

  add_index "payment_p2007_06s", ["created_at"], name: "index_payment_p2007_06s_on_created_at", using: :btree
  add_index "payment_p2007_06s", ["customer_id"], name: "idx_fk_payment_p2007_06_customer_id", using: :btree
  add_index "payment_p2007_06s", ["staff_id"], name: "idx_fk_payment_p2007_06_staff_id", using: :btree
  add_index "payment_p2007_06s", ["updated_at"], name: "index_payment_p2007_06s_on_updated_at", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "customer_id",  limit: 2,                                                         null: false
    t.integer  "staff_id",     limit: 2,                                                         null: false
    t.integer  "rental_id",                                                                      null: false
    t.decimal  "amount",                 precision: 5, scale: 2,                                 null: false
    t.datetime "payment_date",                                                                   null: false
    t.datetime "updated_at",                                     default: '2015-09-26 09:49:53', null: false
    t.datetime "created_at",                                     default: '2015-09-26 09:49:53', null: false
  end

  add_index "payments", ["created_at"], name: "index_payments_on_created_at", using: :btree
  add_index "payments", ["customer_id"], name: "idx_fk_customer_id", using: :btree
  add_index "payments", ["staff_id"], name: "idx_fk_staff_id", using: :btree
  add_index "payments", ["updated_at"], name: "index_payments_on_updated_at", using: :btree

  create_table "rentals", force: :cascade do |t|
    t.datetime "rental_date",                                            null: false
    t.integer  "inventory_id",                                           null: false
    t.integer  "customer_id",  limit: 2,                                 null: false
    t.datetime "return_date"
    t.integer  "staff_id",     limit: 2,                                 null: false
    t.datetime "updated_at",             default: '2015-09-26 09:49:52', null: false
    t.datetime "created_at",             default: '2015-09-26 09:49:53', null: false
  end

  add_index "rentals", ["created_at"], name: "index_rentals_on_created_at", using: :btree
  add_index "rentals", ["inventory_id"], name: "idx_fk_inventory_id", using: :btree
  add_index "rentals", ["rental_date", "inventory_id", "customer_id"], name: "idx_unq_rental_rental_date_inventory_id_customer_id", unique: true, using: :btree

  create_table "staffs", force: :cascade do |t|
    t.string   "first_name", limit: 45,                                 null: false
    t.string   "last_name",  limit: 45,                                 null: false
    t.integer  "address_id", limit: 2,                                  null: false
    t.string   "email",      limit: 50
    t.integer  "store_id",   limit: 2,                                  null: false
    t.boolean  "active",                default: true,                  null: false
    t.string   "username",   limit: 16,                                 null: false
    t.string   "password",   limit: 40
    t.datetime "updated_at",            default: '2015-09-26 09:49:52', null: false
    t.binary   "picture"
    t.datetime "created_at",            default: '2015-09-26 09:49:53', null: false
  end

  add_index "staffs", ["created_at"], name: "index_staffs_on_created_at", using: :btree

  create_table "stores", force: :cascade do |t|
    t.integer  "manager_staff_id", limit: 2,                                 null: false
    t.integer  "address_id",       limit: 2,                                 null: false
    t.datetime "updated_at",                 default: '2015-09-26 09:49:52', null: false
    t.datetime "created_at",                 default: '2015-09-26 09:49:53', null: false
  end

  add_index "stores", ["created_at"], name: "index_stores_on_created_at", using: :btree
  add_index "stores", ["manager_staff_id"], name: "idx_unq_manager_staff_id", unique: true, using: :btree

  add_foreign_key "addresses", "cities", name: "address_city_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "cities", "countries", name: "city_country_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "customers", "addresses", name: "customer_address_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "customers", "stores", name: "customer_store_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "film_actors", "actors", name: "film_actor_actor_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "film_actors", "films", name: "film_actor_film_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "film_categories", "categories", name: "film_category_category_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "film_categories", "films", name: "film_category_film_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "films", "languages", column: "original_language_id", name: "film_original_language_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "films", "languages", name: "film_language_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "inventories", "films", name: "inventory_film_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "inventories", "stores", name: "inventory_store_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "payment_p2007_01s", "customers", name: "payment_p2007_01_customer_id_fkey"
  add_foreign_key "payment_p2007_01s", "rentals", name: "payment_p2007_01_rental_id_fkey"
  add_foreign_key "payment_p2007_01s", "staffs", name: "payment_p2007_01_staff_id_fkey"
  add_foreign_key "payment_p2007_02s", "customers", name: "payment_p2007_02_customer_id_fkey"
  add_foreign_key "payment_p2007_02s", "rentals", name: "payment_p2007_02_rental_id_fkey"
  add_foreign_key "payment_p2007_02s", "staffs", name: "payment_p2007_02_staff_id_fkey"
  add_foreign_key "payment_p2007_03s", "customers", name: "payment_p2007_03_customer_id_fkey"
  add_foreign_key "payment_p2007_03s", "rentals", name: "payment_p2007_03_rental_id_fkey"
  add_foreign_key "payment_p2007_03s", "staffs", name: "payment_p2007_03_staff_id_fkey"
  add_foreign_key "payment_p2007_04s", "customers", name: "payment_p2007_04_customer_id_fkey"
  add_foreign_key "payment_p2007_04s", "rentals", name: "payment_p2007_04_rental_id_fkey"
  add_foreign_key "payment_p2007_04s", "staffs", name: "payment_p2007_04_staff_id_fkey"
  add_foreign_key "payment_p2007_05s", "customers", name: "payment_p2007_05_customer_id_fkey"
  add_foreign_key "payment_p2007_05s", "rentals", name: "payment_p2007_05_rental_id_fkey"
  add_foreign_key "payment_p2007_05s", "staffs", name: "payment_p2007_05_staff_id_fkey"
  add_foreign_key "payment_p2007_06s", "customers", name: "payment_p2007_06_customer_id_fkey"
  add_foreign_key "payment_p2007_06s", "rentals", name: "payment_p2007_06_rental_id_fkey"
  add_foreign_key "payment_p2007_06s", "staffs", name: "payment_p2007_06_staff_id_fkey"
  add_foreign_key "payments", "customers", name: "payment_customer_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "payments", "rentals", name: "payment_rental_id_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "payments", "staffs", name: "payment_staff_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "rentals", "customers", name: "rental_customer_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "rentals", "inventories", name: "rental_inventory_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "rentals", "staffs", name: "rental_staff_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "staffs", "addresses", name: "staff_address_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "staffs", "stores", name: "staff_store_id_fkey"
  add_foreign_key "stores", "addresses", name: "store_address_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "stores", "staffs", column: "manager_staff_id", name: "store_manager_staff_id_fkey", on_update: :cascade, on_delete: :restrict
end
