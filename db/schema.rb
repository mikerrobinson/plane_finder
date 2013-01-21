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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130108213421) do

  create_table "aircrafts", :id => false, :force => true do |t|
    t.string  "id",            :null => false
    t.string  "manufacturer"
    t.string  "model"
    t.integer "aircraft_type"
    t.integer "engine_type"
    t.integer "category"
    t.integer "certification"
    t.integer "engines"
    t.integer "seats"
    t.string  "weight"
    t.integer "cruise_speed"
    t.string  "empty"
  end

  create_table "engines", :force => true do |t|
    t.string  "manufacturer"
    t.string  "model"
    t.integer "type"
    t.integer "horsepower"
    t.integer "thrust"
    t.string  "empty"
  end

  create_table "registrations", :force => true do |t|
    t.string "n_number",           :limit => 5
    t.string "serial_number",      :limit => 30
    t.string "aircraft_id",        :limit => 7
    t.string "engine_id",          :limit => 5
    t.string "year",               :limit => 4
    t.string "type_registrant",    :limit => 1
    t.string "registrant_name",    :limit => 50
    t.string "street_1",           :limit => 33
    t.string "street_2",           :limit => 33
    t.string "city",               :limit => 18
    t.string "state",              :limit => 2
    t.string "zip",                :limit => 10
    t.string "region",             :limit => 1
    t.string "county_mail",        :limit => 3
    t.string "country_mail",       :limit => 2
    t.string "last_activity_date", :limit => 8
    t.string "cert_issue_date",    :limit => 8
    t.string "certification_code", :limit => 10
    t.string "type_aircraft",      :limit => 1
    t.string "type_engine",        :limit => 2
    t.string "status_code",        :limit => 2
    t.string "mode_s_code",        :limit => 8
    t.string "fractional",         :limit => 1
    t.string "airworthiness_date", :limit => 8
    t.string "other_name_1",       :limit => 50
    t.string "other_name_2",       :limit => 50
    t.string "other_name_3",       :limit => 50
    t.string "other_name_4",       :limit => 50
    t.string "other_name_5",       :limit => 50
    t.string "expiration_date",    :limit => 8
    t.string "unique_id",          :limit => 8
    t.string "kit_mfr",            :limit => 30
    t.string "kit_model",          :limit => 20
    t.string "mode_s_hex",         :limit => 10
    t.string "empty"
  end

end
