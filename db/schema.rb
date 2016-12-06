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

ActiveRecord::Schema.define(version: 20161206223946) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "devices", force: :cascade do |t|
    t.string   "particle_id"
    t.json     "params"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["created_at"], name: "index_devices_on_created_at", using: :btree
    t.index ["particle_id"], name: "index_devices_on_particle_id", unique: true, using: :btree
    t.index ["updated_at"], name: "index_devices_on_updated_at", using: :btree
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.string   "token"
    t.string   "refresh_token"
    t.datetime "expires_at"
    t.datetime "revoked_at"
    t.string   "scopes"
    t.integer  "resource_owner_id"
    t.integer  "oauth_application_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["expires_at"], name: "index_oauth_access_tokens_on_expires_at", using: :btree
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
    t.index ["revoked_at"], name: "index_oauth_access_tokens_on_revoked_at", using: :btree
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name"
    t.string   "uid"
    t.string   "secret"
    t.string   "redirect_uri"
    t.string   "scopes"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.boolean  "anonymous"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
