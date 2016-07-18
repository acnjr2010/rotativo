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

ActiveRecord::Schema.define(version: 20160718181107) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bilhetepvs", force: :cascade do |t|
    t.integer  "forma_pagamento"
    t.string   "cnpj"
    t.string   "placa_veiculo"
    t.integer  "vendido_por"
    t.float    "valor_bilhete"
    t.integer  "setor_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
    t.integer  "qt_vagas"
    t.string   "telefone"
    t.integer  "periodo"
    t.string   "bilhete"
    t.integer  "status"
    t.datetime "ativado_em"
  end

  add_index "bilhetepvs", ["user_id"], name: "index_bilhetepvs_on_user_id", using: :btree

  create_table "bilhetes", force: :cascade do |t|
    t.float    "valor_bilhete"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "user_id"
    t.string   "placa_veiculo"
    t.integer  "periodo"
    t.datetime "ativado_em"
    t.integer  "vendido_por"
    t.string   "bilhete"
    t.integer  "status"
    t.integer  "setor_id"
    t.boolean  "gerado",         default: false
    t.string   "transaction_id"
  end

  add_index "bilhetes", ["setor_id"], name: "index_bilhetes_on_setor_id", using: :btree
  add_index "bilhetes", ["user_id"], name: "index_bilhetes_on_user_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.string   "nome"
    t.string   "endereco"
    t.string   "titulo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "setor_id"
    t.integer  "user_id"
    t.float    "valor_bilhete"
    t.text     "description"
    t.string   "transaction_id"
    t.integer  "periodo"
  end

  add_index "orders", ["setor_id"], name: "index_orders_on_setor_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "perfils", force: :cascade do |t|
    t.string   "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "produtos", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.float    "price"
  end

  create_table "setors", force: :cascade do |t|
    t.string   "cor"
    t.float    "preco_periodo"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "qtd_periodo"
    t.integer  "tempo"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "cpf"
    t.string   "nome"
    t.string   "endereco"
    t.string   "telefone"
    t.integer  "perfil_id"
    t.string   "cnpj"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["perfil_id"], name: "index_users_on_perfil_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "veiculos", force: :cascade do |t|
    t.string   "placa_veiculo"
    t.string   "tipo"
    t.string   "modelo"
    t.string   "cor"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
  end

  add_index "veiculos", ["user_id"], name: "index_veiculos_on_user_id", using: :btree

  create_table "vendas", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.string   "setor"
    t.string   "placa_veiculo"
    t.string   "periodo"
  end

  add_index "vendas", ["user_id"], name: "index_vendas_on_user_id", using: :btree

end
