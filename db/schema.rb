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

ActiveRecord::Schema.define(version: 20171209152909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apns_tokens", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "active"
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_apns_tokens_on_active", using: :btree
    t.index ["created_at"], name: "index_apns_tokens_on_created_at", using: :btree
    t.index ["updated_at"], name: "index_apns_tokens_on_updated_at", using: :btree
    t.index ["user_id"], name: "index_apns_tokens_on_user_id", using: :btree
  end

  create_table "devices", force: :cascade do |t|
    t.string   "particle_id"
    t.json     "params"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "presence",      default: false
    t.datetime "last_heard_at"
    t.index ["created_at"], name: "index_devices_on_created_at", using: :btree
    t.index ["particle_id"], name: "index_devices_on_particle_id", unique: true, using: :btree
    t.index ["updated_at"], name: "index_devices_on_updated_at", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "interaction_id"
    t.text     "response"
    t.text     "error"
    t.string   "status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["created_at"], name: "index_events_on_created_at", using: :btree
    t.index ["interaction_id"], name: "index_events_on_interaction_id", using: :btree
    t.index ["status"], name: "index_events_on_status", using: :btree
    t.index ["updated_at"], name: "index_events_on_updated_at", using: :btree
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

  create_table "interactions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "user_device_id"
    t.integer  "photo_id"
    t.string   "name"
    t.text     "description"
    t.integer  "red",            default: 0
    t.integer  "green",          default: 0
    t.integer  "blue",           default: 0
    t.string   "pattern"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["created_at"], name: "index_interactions_on_created_at", using: :btree
    t.index ["photo_id"], name: "index_interactions_on_photo_id", using: :btree
    t.index ["updated_at"], name: "index_interactions_on_updated_at", using: :btree
    t.index ["user_device_id"], name: "index_interactions_on_user_device_id", using: :btree
    t.index ["user_id"], name: "index_interactions_on_user_id", using: :btree
  end

  create_table "invites", force: :cascade do |t|
    t.integer  "checkout_id"
    t.integer  "user_id"
    t.integer  "device_id"
    t.integer  "usage_count", default: 0
    t.integer  "usage_limit"
    t.datetime "expires_at"
    t.datetime "revoked_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["checkout_id"], name: "index_invites_on_checkout_id", using: :btree
    t.index ["created_at"], name: "index_invites_on_created_at", using: :btree
    t.index ["device_id"], name: "index_invites_on_device_id", using: :btree
    t.index ["expires_at"], name: "index_invites_on_expires_at", using: :btree
    t.index ["revoked_at"], name: "index_invites_on_revoked_at", using: :btree
    t.index ["updated_at"], name: "index_invites_on_updated_at", using: :btree
    t.index ["usage_count"], name: "index_invites_on_usage_count", using: :btree
    t.index ["usage_limit"], name: "index_invites_on_usage_limit", using: :btree
    t.index ["user_id"], name: "index_invites_on_user_id", using: :btree
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

  create_table "photos", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "token"
    t.string   "filename"
    t.string   "ext"
    t.string   "mime_type"
    t.integer  "original_height"
    t.integer  "original_width"
    t.string   "sha"
    t.string   "ip_address"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "shares", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "interaction_id"
    t.integer  "usage_limit"
    t.integer  "usage_count",    default: 0
    t.datetime "expires_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["created_at"], name: "index_shares_on_created_at", using: :btree
    t.index ["expires_at"], name: "index_shares_on_expires_at", using: :btree
    t.index ["interaction_id"], name: "index_shares_on_interaction_id", using: :btree
    t.index ["updated_at"], name: "index_shares_on_updated_at", using: :btree
    t.index ["usage_count"], name: "index_shares_on_usage_count", using: :btree
    t.index ["usage_limit"], name: "index_shares_on_usage_limit", using: :btree
    t.index ["user_id"], name: "index_shares_on_user_id", using: :btree
  end

  create_table "user_devices", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "device_id"
    t.integer  "invite_id"
    t.boolean  "direct",     default: false
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["created_at"], name: "index_user_devices_on_created_at", using: :btree
    t.index ["name"], name: "index_user_devices_on_name", using: :btree
    t.index ["updated_at"], name: "index_user_devices_on_updated_at", using: :btree
    t.index ["user_id", "device_id"], name: "index_user_devices_on_user_id_and_device_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.boolean  "anonymous"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
