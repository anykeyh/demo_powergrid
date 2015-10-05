class CreateDatabase < ActiveRecord::Migration
  def change

    # These are extensions that must be enabled in order to support this database
    enable_extension "plpgsql"

    create_table "actor", primary_key: "actor_id", force: :cascade do |t|
      t.string   "first_name",  limit: 45,                   null: false
      t.string   "last_name",   limit: 45,                   null: false
      t.datetime "last_update",            default: "now()", null: false
    end

    add_index "actor", ["last_name"], name: "idx_actor_last_name", using: :btree

    create_table "address", primary_key: "address_id", force: :cascade do |t|
      t.string   "address",     limit: 50,                   null: false
      t.string   "address2",    limit: 50
      t.string   "district",    limit: 20,                   null: false
      t.integer  "city_id",     limit: 2,                    null: false
      t.string   "postal_code", limit: 10
      t.string   "phone",       limit: 20,                   null: false
      t.datetime "last_update",            default: "now()", null: false
    end

    add_index "address", ["city_id"], name: "idx_fk_city_id", using: :btree

    create_table "category", primary_key: "category_id", force: :cascade do |t|
      t.string   "name",        limit: 25,                   null: false
      t.datetime "last_update",            default: "now()", null: false
    end

    create_table "city", primary_key: "city_id", force: :cascade do |t|
      t.string   "city",        limit: 50,                   null: false
      t.integer  "country_id",  limit: 2,                    null: false
      t.datetime "last_update",            default: "now()", null: false
    end

    add_index "city", ["country_id"], name: "idx_fk_country_id", using: :btree

    create_table "country", primary_key: "country_id", force: :cascade do |t|
      t.string   "country",     limit: 50,                   null: false
      t.datetime "last_update",            default: "now()", null: false
    end

    create_table "customer", primary_key: "customer_id", force: :cascade do |t|
      t.integer  "store_id",    limit: 2,                    null: false
      t.string   "first_name",  limit: 45,                   null: false
      t.string   "last_name",   limit: 45,                   null: false
      t.string   "email",       limit: 50
      t.integer  "address_id",  limit: 2,                    null: false
      t.boolean  "activebool",             default: true,    null: false
      t.date     "create_date",                              null: false
      t.datetime "last_update",            default: "now()"
      t.integer  "active"
    end

    add_index "customer", ["address_id"], name: "idx_fk_address_id", using: :btree
    add_index "customer", ["last_name"], name: "idx_last_name", using: :btree
    add_index "customer", ["store_id"], name: "idx_fk_store_id", using: :btree

    create_table  "film", primary_key: "film_id", force: :cascade do |t|
      t.string    "title", null: false
      t.text      "description"
      t.integer   "release_year"
      t.integer   "language_id", null:false
      t.integer   "original_language_id"
      t.integer   "rental_duration", default: 3, null: false
      t.decimal   "rental_rate", default: 4.99, precision: 5, scale: 2, null: false
      t.integer   "length"
      t.decimal   "replacement_cost", precision: 5, scale: 2, default: 19.99, null: false
      t.string    "rating", default: "G"
      t.datetime  "last_update", null: false
      t.text      "special_features", array: true
      t.tsvector  "fulltext", null: false
    end

    create_table "film_actor", id: false, force: :cascade do |t|
      t.integer  "actor_id",    limit: 2,                   null: false
      t.integer  "film_id",     limit: 2,                   null: false
      t.datetime "last_update",           default: "now()", null: false
    end

    add_index "film_actor", ["film_id"], name: "idx_fk_film_id", using: :btree

    create_table "film_category", id: false, force: :cascade do |t|
      t.integer  "film_id",     limit: 2,                   null: false
      t.integer  "category_id", limit: 2,                   null: false
      t.datetime "last_update",           default: "now()", null: false
    end

    create_table "inventory", primary_key: "inventory_id", force: :cascade do |t|
      t.integer  "film_id",     limit: 2,                   null: false
      t.integer  "store_id",    limit: 2,                   null: false
      t.datetime "last_update",           default: "now()", null: false
    end

    add_index "inventory", ["store_id", "film_id"], name: "idx_store_id_film_id", using: :btree

    create_table "language", primary_key: "language_id", force: :cascade do |t|
      t.string   "name",        limit: 20,                   null: false
      t.datetime "last_update",            default: "now()", null: false
    end

    create_table "payment", primary_key: "payment_id", force: :cascade do |t|
      t.integer  "customer_id",  limit: 2,                         null: false
      t.integer  "staff_id",     limit: 2,                         null: false
      t.integer  "rental_id",                                      null: false
      t.decimal  "amount",                 precision: 5, scale: 2, null: false
      t.datetime "payment_date",                                   null: false
    end

    add_index "payment", ["customer_id"], name: "idx_fk_customer_id", using: :btree
    add_index "payment", ["staff_id"], name: "idx_fk_staff_id", using: :btree

    create_table "payment_p2007_01", id: false, force: :cascade do |t|
      t.integer  "payment_id",                                     default: "nextval('payment_payment_id_seq'::regclass)", null: false
      t.integer  "customer_id",  limit: 2,                                                                                 null: false
      t.integer  "staff_id",     limit: 2,                                                                                 null: false
      t.integer  "rental_id",                                                                                              null: false
      t.decimal  "amount",                 precision: 5, scale: 2,                                                         null: false
      t.datetime "payment_date",                                                                                           null: false
    end

    add_index "payment_p2007_01", ["customer_id"], name: "idx_fk_payment_p2007_01_customer_id", using: :btree
    add_index "payment_p2007_01", ["staff_id"], name: "idx_fk_payment_p2007_01_staff_id", using: :btree

    create_table "payment_p2007_02", id: false, force: :cascade do |t|
      t.integer  "payment_id",                                     default: "nextval('payment_payment_id_seq'::regclass)", null: false
      t.integer  "customer_id",  limit: 2,                                                                                 null: false
      t.integer  "staff_id",     limit: 2,                                                                                 null: false
      t.integer  "rental_id",                                                                                              null: false
      t.decimal  "amount",                 precision: 5, scale: 2,                                                         null: false
      t.datetime "payment_date",                                                                                           null: false
    end

    add_index "payment_p2007_02", ["customer_id"], name: "idx_fk_payment_p2007_02_customer_id", using: :btree
    add_index "payment_p2007_02", ["staff_id"], name: "idx_fk_payment_p2007_02_staff_id", using: :btree

    create_table "payment_p2007_03", id: false, force: :cascade do |t|
      t.integer  "payment_id",                                     default: "nextval('payment_payment_id_seq'::regclass)", null: false
      t.integer  "customer_id",  limit: 2,                                                                                 null: false
      t.integer  "staff_id",     limit: 2,                                                                                 null: false
      t.integer  "rental_id",                                                                                              null: false
      t.decimal  "amount",                 precision: 5, scale: 2,                                                         null: false
      t.datetime "payment_date",                                                                                           null: false
    end

    add_index "payment_p2007_03", ["customer_id"], name: "idx_fk_payment_p2007_03_customer_id", using: :btree
    add_index "payment_p2007_03", ["staff_id"], name: "idx_fk_payment_p2007_03_staff_id", using: :btree

    create_table "payment_p2007_04", id: false, force: :cascade do |t|
      t.integer  "payment_id",                                     default: "nextval('payment_payment_id_seq'::regclass)", null: false
      t.integer  "customer_id",  limit: 2,                                                                                 null: false
      t.integer  "staff_id",     limit: 2,                                                                                 null: false
      t.integer  "rental_id",                                                                                              null: false
      t.decimal  "amount",                 precision: 5, scale: 2,                                                         null: false
      t.datetime "payment_date",                                                                                           null: false
    end

    add_index "payment_p2007_04", ["customer_id"], name: "idx_fk_payment_p2007_04_customer_id", using: :btree
    add_index "payment_p2007_04", ["staff_id"], name: "idx_fk_payment_p2007_04_staff_id", using: :btree

    create_table "payment_p2007_05", id: false, force: :cascade do |t|
      t.integer  "payment_id",                                     default: "nextval('payment_payment_id_seq'::regclass)", null: false
      t.integer  "customer_id",  limit: 2,                                                                                 null: false
      t.integer  "staff_id",     limit: 2,                                                                                 null: false
      t.integer  "rental_id",                                                                                              null: false
      t.decimal  "amount",                 precision: 5, scale: 2,                                                         null: false
      t.datetime "payment_date",                                                                                           null: false
    end

    add_index "payment_p2007_05", ["customer_id"], name: "idx_fk_payment_p2007_05_customer_id", using: :btree
    add_index "payment_p2007_05", ["staff_id"], name: "idx_fk_payment_p2007_05_staff_id", using: :btree

    create_table "payment_p2007_06", id: false, force: :cascade do |t|
      t.integer  "payment_id",                                     default: "nextval('payment_payment_id_seq'::regclass)", null: false
      t.integer  "customer_id",  limit: 2,                                                                                 null: false
      t.integer  "staff_id",     limit: 2,                                                                                 null: false
      t.integer  "rental_id",                                                                                              null: false
      t.decimal  "amount",                 precision: 5, scale: 2,                                                         null: false
      t.datetime "payment_date",                                                                                           null: false
    end

    add_index "payment_p2007_06", ["customer_id"], name: "idx_fk_payment_p2007_06_customer_id", using: :btree
    add_index "payment_p2007_06", ["staff_id"], name: "idx_fk_payment_p2007_06_staff_id", using: :btree

    create_table "rental", primary_key: "rental_id", force: :cascade do |t|
      t.datetime "rental_date",                              null: false
      t.integer  "inventory_id",                             null: false
      t.integer  "customer_id",  limit: 2,                   null: false
      t.datetime "return_date"
      t.integer  "staff_id",     limit: 2,                   null: false
      t.datetime "last_update",            default: "now()", null: false
    end

    add_index "rental", ["inventory_id"], name: "idx_fk_inventory_id", using: :btree
    add_index "rental", ["rental_date", "inventory_id", "customer_id"], name: "idx_unq_rental_rental_date_inventory_id_customer_id", unique: true, using: :btree

    create_table "staff", primary_key: "staff_id", force: :cascade do |t|
      t.string   "first_name",  limit: 45,                   null: false
      t.string   "last_name",   limit: 45,                   null: false
      t.integer  "address_id",  limit: 2,                    null: false
      t.string   "email",       limit: 50
      t.integer  "store_id",    limit: 2,                    null: false
      t.boolean  "active",                 default: true,    null: false
      t.string   "username",    limit: 16,                   null: false
      t.string   "password",    limit: 40
      t.datetime "last_update",            default: "now()", null: false
      t.binary   "picture"
    end

    create_table "store", primary_key: "store_id", force: :cascade do |t|
      t.integer  "manager_staff_id", limit: 2,                   null: false
      t.integer  "address_id",       limit: 2,                   null: false
      t.datetime "last_update",                default: "now()", null: false
    end

    add_index "store", ["manager_staff_id"], name: "idx_unq_manager_staff_id", unique: true, using: :btree

    add_foreign_key "address", "city", primary_key: "city_id", name: "address_city_id_fkey", on_update: :cascade, on_delete: :restrict
    add_foreign_key "city", "country", primary_key: "country_id", name: "city_country_id_fkey", on_update: :cascade, on_delete: :restrict
    add_foreign_key "customer", "address", primary_key: "address_id", name: "customer_address_id_fkey", on_update: :cascade, on_delete: :restrict
    add_foreign_key "customer", "store", primary_key: "store_id", name: "customer_store_id_fkey", on_update: :cascade, on_delete: :restrict
    add_foreign_key "film", "language", column: "original_language_id", primary_key: "language_id", name: "film_original_language_id_fkey", on_update: :cascade, on_delete: :restrict
    add_foreign_key "film", "language", primary_key: "language_id", name: "film_language_id_fkey", on_update: :cascade, on_delete: :restrict
    add_foreign_key "film_actor", "actor", primary_key: "actor_id", name: "film_actor_actor_id_fkey", on_update: :cascade, on_delete: :restrict
    add_foreign_key "film_actor", "film", primary_key: "film_id", name: "film_actor_film_id_fkey", on_update: :cascade, on_delete: :restrict
    add_foreign_key "film_category", "category", primary_key: "category_id", name: "film_category_category_id_fkey", on_update: :cascade, on_delete: :restrict
    add_foreign_key "film_category", "film", primary_key: "film_id", name: "film_category_film_id_fkey", on_update: :cascade, on_delete: :restrict
    add_foreign_key "inventory", "film", primary_key: "film_id", name: "inventory_film_id_fkey", on_update: :cascade, on_delete: :restrict
    add_foreign_key "inventory", "store", primary_key: "store_id", name: "inventory_store_id_fkey", on_update: :cascade, on_delete: :restrict
    add_foreign_key "payment", "customer", primary_key: "customer_id", name: "payment_customer_id_fkey", on_update: :cascade, on_delete: :restrict
    add_foreign_key "payment", "rental", primary_key: "rental_id", name: "payment_rental_id_fkey", on_update: :cascade, on_delete: :nullify
    add_foreign_key "payment", "staff", primary_key: "staff_id", name: "payment_staff_id_fkey", on_update: :cascade, on_delete: :restrict
    add_foreign_key "payment_p2007_01", "customer", primary_key: "customer_id", name: "payment_p2007_01_customer_id_fkey"
    add_foreign_key "payment_p2007_01", "rental", primary_key: "rental_id", name: "payment_p2007_01_rental_id_fkey"
    add_foreign_key "payment_p2007_01", "staff", primary_key: "staff_id", name: "payment_p2007_01_staff_id_fkey"
    add_foreign_key "payment_p2007_02", "customer", primary_key: "customer_id", name: "payment_p2007_02_customer_id_fkey"
    add_foreign_key "payment_p2007_02", "rental", primary_key: "rental_id", name: "payment_p2007_02_rental_id_fkey"
    add_foreign_key "payment_p2007_02", "staff", primary_key: "staff_id", name: "payment_p2007_02_staff_id_fkey"
    add_foreign_key "payment_p2007_03", "customer", primary_key: "customer_id", name: "payment_p2007_03_customer_id_fkey"
    add_foreign_key "payment_p2007_03", "rental", primary_key: "rental_id", name: "payment_p2007_03_rental_id_fkey"
    add_foreign_key "payment_p2007_03", "staff", primary_key: "staff_id", name: "payment_p2007_03_staff_id_fkey"
    add_foreign_key "payment_p2007_04", "customer", primary_key: "customer_id", name: "payment_p2007_04_customer_id_fkey"
    add_foreign_key "payment_p2007_04", "rental", primary_key: "rental_id", name: "payment_p2007_04_rental_id_fkey"
    add_foreign_key "payment_p2007_04", "staff", primary_key: "staff_id", name: "payment_p2007_04_staff_id_fkey"
    add_foreign_key "payment_p2007_05", "customer", primary_key: "customer_id", name: "payment_p2007_05_customer_id_fkey"
    add_foreign_key "payment_p2007_05", "rental", primary_key: "rental_id", name: "payment_p2007_05_rental_id_fkey"
    add_foreign_key "payment_p2007_05", "staff", primary_key: "staff_id", name: "payment_p2007_05_staff_id_fkey"
    add_foreign_key "payment_p2007_06", "customer", primary_key: "customer_id", name: "payment_p2007_06_customer_id_fkey"
    add_foreign_key "payment_p2007_06", "rental", primary_key: "rental_id", name: "payment_p2007_06_rental_id_fkey"
    add_foreign_key "payment_p2007_06", "staff", primary_key: "staff_id", name: "payment_p2007_06_staff_id_fkey"
    add_foreign_key "rental", "customer", primary_key: "customer_id", name: "rental_customer_id_fkey", on_update: :cascade, on_delete: :restrict
    add_foreign_key "rental", "inventory", primary_key: "inventory_id", name: "rental_inventory_id_fkey", on_update: :cascade, on_delete: :restrict
    add_foreign_key "rental", "staff", primary_key: "staff_id", name: "rental_staff_id_fkey", on_update: :cascade, on_delete: :restrict
    add_foreign_key "staff", "address", primary_key: "address_id", name: "staff_address_id_fkey", on_update: :cascade, on_delete: :restrict
    add_foreign_key "staff", "store", primary_key: "store_id", name: "staff_store_id_fkey"
    add_foreign_key "store", "address", primary_key: "address_id", name: "store_address_id_fkey", on_update: :cascade, on_delete: :restrict
    add_foreign_key "store", "staff", column: "manager_staff_id", primary_key: "staff_id", name: "store_manager_staff_id_fkey", on_update: :cascade, on_delete: :restrict

  end
end
