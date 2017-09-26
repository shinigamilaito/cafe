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

ActiveRecord::Schema.define(version: 20170902195416) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "address"
    t.string   "organization"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "entradas", force: :cascade do |t|
    t.datetime "date"
    t.bigint   "numero_entrada"
    t.string   "driver"
    t.string   "entregado_por"
    t.bigint   "total_partidas", default: 1
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "partidas", force: :cascade do |t|
    t.bigint   "identificador",     default: 1
    t.integer  "entrada_id"
    t.string   "kilogramos_brutos"
    t.bigint   "numero_bultos"
    t.string   "tara"
    t.string   "kilogramos_netos"
    t.string   "humedad"
    t.integer  "type_coffee_id"
    t.string   "calidad_cafe"
    t.integer  "client_id"
    t.text     "observaciones"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["client_id"], name: "index_partidas_on_client_id", using: :btree
    t.index ["entrada_id"], name: "index_partidas_on_entrada_id", using: :btree
    t.index ["type_coffee_id"], name: "index_partidas_on_type_coffee_id", using: :btree
  end

  create_table "type_coffees", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "partidas", "clients"
  add_foreign_key "partidas", "entradas"
  add_foreign_key "partidas", "type_coffees"
end
