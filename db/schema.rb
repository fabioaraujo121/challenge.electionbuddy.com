# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_230_612_191_818) do
  create_table 'audit_logs', force: :cascade do |t|
    t.string 'auditable_type', null: false
    t.integer 'auditable_id', null: false
    t.string 'owner_type', null: false
    t.integer 'owner_id', null: false
    t.json 'value'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[auditable_type auditable_id], name: 'index_audit_logs_on_auditable'
    t.index %w[owner_type owner_id], name: 'index_audit_logs_on_owner'
  end
end
