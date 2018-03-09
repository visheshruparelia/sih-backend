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

ActiveRecord::Schema.define(version: 20180309115244) do

  create_table "allfiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.binary "qrcode"
    t.datetime "timeRecievedCurrentOwner"
    t.integer "status", default: 0
    t.binary "customData"
    t.binary "history"
    t.integer "created_by_id"
    t.integer "currentOwner_id"
    t.index ["created_by_id"], name: "index_allfiles_on_created_by_id"
    t.index ["currentOwner_id"], name: "index_allfiles_on_currentOwner_id"
  end

  create_table "file_users", force: :cascade do |t|
    t.boolean "modify", default: false
    t.boolean "view", default: false
    t.integer "fileId_id"
    t.integer "userId_id"
    t.index ["fileId_id"], name: "index_file_users_on_fileId_id"
    t.index ["userId_id"], name: "index_file_users_on_userId_id"
  end

  create_table "group_groups", force: :cascade do |t|
    t.integer "groupId_id"
    t.integer "authorityOver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authorityOver_id"], name: "index_group_groups_on_authorityOver_id"
    t.index ["groupId_id"], name: "index_group_groups_on_groupId_id"
  end

  create_table "group_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.boolean "defaultIncoming"
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "isDepartment"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

end
