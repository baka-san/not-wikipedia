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

ActiveRecord::Schema.define(version: 20171205083208) do

  create_table "collaborations", force: :cascade do |t|
    t.integer "wiki_id"
    t.integer "collaborator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collaborator_id"], name: "index_collaborations_on_collaborator_id"
    t.index ["id"], name: "index_collaborations_on_id", unique: true
    t.index ["wiki_id", "collaborator_id"], name: "index_collaborations_on_wiki_id_and_collaborator_id", unique: true
    t.index ["wiki_id"], name: "index_collaborations_on_wiki_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "user_id"
    t.string "stripe_subscription_id"
    t.integer "current_period_start"
    t.integer "current_period_end"
    t.string "plan", default: "premium"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "autopay", default: true
    t.index ["stripe_subscription_id"], name: "index_subscriptions_on_stripe_subscription_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "username"
    t.string "stripe_customer_id"
    t.datetime "subscribed_at"
    t.datetime "subscription_expires_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["stripe_customer_id"], name: "index_users_on_stripe_customer_id", unique: true
    t.index ["subscribed_at"], name: "subscribed_at_for_users"
    t.index ["subscription_expires_at"], name: "expiring_subscritions_on_users"
  end

  create_table "wikis", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.boolean "private", default: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wikis_on_user_id"
  end

end
