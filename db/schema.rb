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

ActiveRecord::Schema.define(version: 2018_09_06_124711) do

  create_table "attribute_mappers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email_address"
    t.string "department"
    t.string "phone_number"
    t.string "postal_code"
    t.string "perfecture"
    t.string "ward"
    t.string "address"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_attribute_mappers_on_company_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.integer "sync_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_companies_on_name", unique: true
  end

  create_table "domains", force: :cascade do |t|
    t.string "domain"
    t.string "protocol"
    t.integer "port"
    t.string "user_base"
    t.string "user_dn"
    t.string "user_password"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_domains_on_company_id"
    t.index ["domain"], name: "index_domains_on_domain", unique: true
  end

  create_table "groups", force: :cascade do |t|
    t.string "domain_name"
    t.string "usn"
    t.integer "domain_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain_id"], name: "index_groups_on_domain_id"
  end

  create_table "search_filters", force: :cascade do |t|
    t.string "label"
    t.string "group"
    t.boolean "user_domain_users_group"
    t.boolean "is_match"
    t.boolean "is_sync_required"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_search_filters_on_group_id"
  end

  create_table "search_operations", force: :cascade do |t|
    t.string "source_dc"
    t.integer "usn"
    t.string "status"
    t.date "status_update_date"
    t.boolean "is_full_sync"
    t.string "group_update_type"
    t.integer "group_id"
    t.integer "domain_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain_id"], name: "index_search_operations_on_domain_id"
    t.index ["group_id"], name: "index_search_operations_on_group_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "distinguished_name"
    t.string "base"
    t.string "object_guid"
    t.boolean "account_enabled"
    t.boolean "current_member"
    t.boolean "sync_required"
    t.integer "usn"
    t.integer "company_id"
    t.integer "domain_id"
    t.integer "group_id"
    t.integer "search_filter_id"
    t.integer "search_operation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["domain_id"], name: "index_users_on_domain_id"
    t.index ["group_id"], name: "index_users_on_group_id"
    t.index ["search_filter_id"], name: "index_users_on_search_filter_id"
    t.index ["search_operation_id"], name: "index_users_on_search_operation_id"
  end

end
