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

ActiveRecord::Schema.define(version: 20180331011129) do

  create_table "allfiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.datetime "timeRecievedCurrentOwner"
    t.integer "status", default: 0
    t.binary "customData"
    t.binary "history"
    t.integer "created_by_id"
    t.integer "currentOwner_id"
    t.integer "priority", default: 0
    t.integer "fileId", default: 0, null: false
    t.string "registeredBy"
    t.integer "group_id_id"
    t.integer "dept_id"
    t.index ["created_by_id"], name: "index_allfiles_on_created_by_id"
    t.index ["currentOwner_id"], name: "index_allfiles_on_currentOwner_id"
    t.index ["dept_id"], name: "index_allfiles_on_dept_id"
    t.index ["group_id_id"], name: "index_allfiles_on_group_id_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.integer "head_id"
    t.integer "deptId", default: 0, null: false
    t.index ["head_id"], name: "index_departments_on_head_id"
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
    t.boolean "isDepartment", default: false
    t.integer "dept_id"
    t.index ["dept_id"], name: "index_groups_on_dept_id"
  end

  create_table "histories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "changed_by_id"
    t.integer "file_id"
    t.datetime "change_time"
    t.integer "status_from"
    t.integer "status_to"
    t.string "nextNode"
    t.index ["changed_by_id"], name: "index_histories_on_changed_by_id"
    t.index ["file_id"], name: "index_histories_on_file_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.text "tokens"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

end
