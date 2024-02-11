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

ActiveRecord::Schema.define(version: 2024_02_11_004908) do

  create_table "admins", force: :cascade do |t|
    t.string "email", null: false
    t.string "full_name"
    t.string "uid"
    t.string "avatar_url"
    t.boolean "superadmin", default: false
    t.boolean "admin", default: false
    t.boolean "lesseradmin", default: false
    t.boolean "support", default: true
    t.boolean "disabled", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bio", limit: 400, default: "No user bio set"
    t.integer "theme", default: 0, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "group_blacklists", force: :cascade do |t|
    t.integer "groupid"
    t.integer "rankid"
    t.string "reason"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ip_bans", force: :cascade do |t|
    t.string "ip"
    t.string "reason"
    t.string "actioneremail"
    t.string "incidentid"
    t.datetime "until"
    t.datetime "appealabledate"
    t.boolean "appealable", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ip"], name: "index_ip_bans_on_ip", unique: true
  end

  create_table "licenses", force: :cascade do |t|
    t.integer "userid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kgc_license", default: 0
    t.integer "timeclock_license", default: 0
    t.string "comment"
    t.index ["userid"], name: "index_licenses_on_userid", unique: true
  end

  create_table "user_blacklist_requests", force: :cascade do |t|
    t.integer "targetuserid", null: false
    t.integer "suggestedlevel", null: false
    t.string "reason", null: false
    t.string "evidence", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.string "claimeremail"
    t.boolean "claimed", default: false
    t.boolean "licenserevocneeded", default: false
    t.boolean "completed", default: false
    t.string "requesteremail", default: "looking thru glass eyes, give it a few tries", null: false
    t.index ["targetuserid"], name: "index_user_blacklist_requests_on_targetuserid", unique: true
  end

  create_table "user_blacklists", force: :cascade do |t|
    t.integer "userid"
    t.string "reason"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["userid"], name: "index_user_blacklists_on_userid", unique: true
  end

end
