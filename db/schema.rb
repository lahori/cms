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

ActiveRecord::Schema.define(version: 20180212194727) do

  create_table "appliances", force: :cascade do |t|
    t.string   "name",         limit: 256
    t.string   "manufacturer"
    t.string   "model"
    t.string   "serial"
    t.string   "ip_addr"
    t.string   "user_name"
    t.string   "password"
    t.string   "url"
    t.integer  "system_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["name"], name: "index_appliances_on_name", unique: true
    t.index ["system_id"], name: "index_appliances_on_system_id"
  end

  create_table "cpus", force: :cascade do |t|
    t.integer  "chip_id"
    t.string   "model",        limit: 128
    t.string   "vendor_id",    limit: 64
    t.integer  "cores"
    t.integer  "frequency"
    t.integer  "threads"
    t.integer  "appliance_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["appliance_id"], name: "index_cpus_on_appliance_id"
  end

  create_table "disks", force: :cascade do |t|
    t.string   "device_name"
    t.string   "model",          limit: 128
    t.string   "vendor_id",      limit: 128
    t.string   "product_id",     limit: 128
    t.string   "serial",         limit: 128
    t.string   "revision",       limit: 64
    t.string   "size",           limit: 128
    t.string   "media_type",     limit: 64
    t.string   "interface",      limit: 64
    t.string   "state",          limit: 64
    t.string   "location",       limit: 128
    t.integer  "appliance_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "logical_device", limit: 128
    t.index ["appliance_id"], name: "index_disks_on_appliance_id"
  end

  create_table "enclosures", force: :cascade do |t|
    t.string   "chasis_id",       limit: 128
    t.string   "model",           limit: 128
    t.string   "vendor_id",       limit: 128
    t.string   "product_id",      limit: 128
    t.string   "revision",        limit: 128
    t.integer  "total_bay_count"
    t.integer  "used_bay_count"
    t.string   "serial_num",      limit: 128
    t.integer  "appliance_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["appliance_id"], name: "index_enclosures_on_appliance_id"
  end

  create_table "hbas", force: :cascade do |t|
    t.string   "adapter_id",          limit: 128
    t.string   "model",               limit: 128
    t.string   "product_id",          limit: 128
    t.string   "vendor_id",           limit: 128
    t.string   "adaptor_description", limit: 256
    t.string   "hw_version",          limit: 64
    t.string   "fw_version",          limit: 64
    t.string   "driver_name",         limit: 128
    t.string   "driver_version",      limit: 128
    t.integer  "lu_count"
    t.integer  "port_count"
    t.integer  "peer_count"
    t.integer  "appliance_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["appliance_id"], name: "index_hbas_on_appliance_id"
  end

  create_table "nics", force: :cascade do |t|
    t.string   "mac",          limit: 128
    t.string   "media_type",   limit: 128
    t.string   "name",         limit: 128
    t.integer  "speed"
    t.string   "duplex",       limit: 64
    t.string   "state",        limit: 64
    t.integer  "appliance_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["appliance_id"], name: "index_nics_on_appliance_id"
  end

  create_table "pool_configurations", force: :cascade do |t|
    t.string   "name"
    t.string   "redundancy"
    t.integer  "max_devices"
    t.integer  "vdev_size"
    t.string   "media_type"
    t.string   "disk_size"
    t.string   "enclosures"
    t.boolean  "enclosure_redundancy"
    t.boolean  "force"
    t.integer  "appliance_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["appliance_id"], name: "index_pool_configurations_on_appliance_id"
  end

  create_table "systems", force: :cascade do |t|
    t.string   "name"
    t.string   "system_type", limit: 24
    t.string   "purpose"
    t.string   "status"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["name"], name: "index_systems_on_name", unique: true
  end

end
