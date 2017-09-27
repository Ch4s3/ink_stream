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

ActiveRecord::Schema.define(version: 20170926172103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.string "link"
    t.date "date"
    t.bigint "publication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "excerpt"
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }, null: false
    t.index ["publication_id"], name: "index_articles_on_publication_id"
    t.index ["title", "publication_id"], name: "index_articles_on_title_and_publication_id"
    t.index ["title"], name: "index_articles_on_title"
  end

  create_table "publications", force: :cascade do |t|
    t.string "name"
    t.string "site"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "score"
    t.index ["name"], name: "index_publications_on_name"
  end

  add_foreign_key "articles", "publications"
end
