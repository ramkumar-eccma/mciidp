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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160203043335) do

  create_table "a_seg_1000", force: :cascade do |t|
    t.string   "TYPE",               limit: 255
    t.string   "FSC",                limit: 255
    t.string   "NIIN",               limit: 255
    t.string   "NSN",                limit: 255
    t.string   "FSG_3994",           limit: 255
    t.string   "FSC_WI_FSG_3996",    limit: 255
    t.string   "NCB_CD_4130",        limit: 255
    t.string   "I_I_NBR_4131",       limit: 255
    t.string   "FIIG_4065",          limit: 255
    t.string   "INC_4080",           limit: 255
    t.string   "short_desc",         limit: 255,  null: false
    t.string   "long_desc",          limit: 2000, null: false
    t.string   "SHRT_NM_2301",       limit: 255
    t.string   "NAIN_5020",          limit: 255
    t.string   "CRITL_CD_FIIG_3843", limit: 255
    t.string   "TYP_II_4820",        limit: 255
    t.string   "RPDMRC_4765",        limit: 255
    t.string   "DEMIL_CD_0167",      limit: 255
    t.string   "DT_NIIN_ASGMT_2180", limit: 255
    t.string   "HMIC_0865",          limit: 255
    t.string   "ESD_EMI_CD_2043",    limit: 255
    t.string   "PMIC_0802",          limit: 255
    t.string   "ADPEC_0801",         limit: 255
    t.string   "TEST",               limit: 255
    t.string   "Country",            limit: 50
    t.string   "Concept_ID",         limit: 50
    t.string   "definition_ID",      limit: 50
    t.string   "Term_ID",            limit: 50
    t.string   "Term",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "a_seg_1000", ["NSN"], name: "NSN", using: :btree

  create_table "a_segments", force: :cascade do |t|
    t.string   "TYPE",                limit: 255
    t.string   "FSC",                 limit: 255
    t.string   "NIIN",                limit: 255
    t.string   "ECCMA_NSN",           limit: 255
    t.string   "FSG_3994",            limit: 255
    t.string   "FSC_WI_FSG_3996",     limit: 255
    t.string   "NCB_CD_4130",         limit: 255
    t.string   "I_I_NBR_4131",        limit: 255
    t.string   "FIIG_4065",           limit: 255
    t.string   "INC_4080",            limit: 255
    t.string   "short_desc",          limit: 255,  null: false
    t.string   "long_desc",           limit: 2000, null: false
    t.string   "SHRT_NM_2301",        limit: 255
    t.string   "NAIN_5020",           limit: 255
    t.string   "CRITL_CD_FIIG_3843",  limit: 255
    t.string   "TYP_II_4820",         limit: 255
    t.string   "RPDMRC_4765",         limit: 255
    t.string   "DEMIL_CD_0167",       limit: 255
    t.string   "DT_NIIN_ASGMT_2180",  limit: 255
    t.string   "HMIC_0865",           limit: 255
    t.string   "ESD_EMI_CD_2043",     limit: 255
    t.string   "PMIC_0802",           limit: 255
    t.string   "ADPEC_0801",          limit: 255
    t.string   "ECCMA_TEST",          limit: 255
    t.string   "ECCMA_Country",       limit: 50
    t.string   "ECCMA_Concept_ID",    limit: 50
    t.string   "ECCMA_definition_ID", limit: 50
    t.string   "ECCMA_Term_ID",       limit: 50
    t.string   "ECCMA_Term",          limit: 255
    t.string   "ECCMA_source",        limit: 255,  null: false
    t.string   "ECCMA_name",          limit: 255,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "a_segments", ["ECCMA_Concept_ID"], name: "Concept_ID", using: :btree
  add_index "a_segments", ["ECCMA_NSN"], name: "NSN", using: :btree
  add_index "a_segments", ["ECCMA_Term_ID"], name: "Term_ID", using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "Organization_name",      limit: 255
    t.string   "Organization_ID",        limit: 255
    t.string   "Individual_ID",          limit: 255
    t.integer  "level",                  limit: 4
    t.string   "designation",            limit: 255
    t.integer  "role",                   limit: 4
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "cage_details", id: false, force: :cascade do |t|
    t.string "CAGE_CD",   limit: 10,  null: false
    t.string "RP_CAGE",   limit: 10
    t.string "CAGE_Name", limit: 255
    t.string "ST_ADRS_1", limit: 255
    t.string "ST_ADRS_2", limit: 255
    t.string "POBOX",     limit: 50
    t.string "CITY",      limit: 255
    t.string "ZIP_CD",    limit: 50
    t.string "COUNTRY",   limit: 50
    t.string "TEL_NBR",   limit: 255
  end

  add_index "cage_details", ["CAGE_CD"], name: "CAGE_CD", using: :btree
  add_index "cage_details", ["CAGE_Name"], name: "CAGE_Name", using: :btree

  create_table "cmm_classifications", primary_key: "cat_id", force: :cascade do |t|
    t.string   "username",             limit: 100
    t.string   "realname",             limit: 255
    t.string   "igid",                 limit: 255
    t.string   "catalog_name",         limit: 255,  null: false
    t.string   "material_id",          limit: 150
    t.datetime "datecreated"
    t.datetime "datedeleted"
    t.string   "legacy_description",   limit: 2000
    t.string   "short_description",    limit: 2000
    t.string   "long_description",     limit: 2000
    t.string   "RGref",                limit: 150
    t.string   "location",             limit: 150
    t.string   "supplier_id",          limit: 100
    t.string   "class",                limit: 255
    t.string   "class_id",             limit: 50
    t.string   "supplier_material_no", limit: 50
    t.integer  "cmm_material_no",      limit: 4
    t.datetime "lastmodified"
    t.string   "organization_ID",      limit: 250
    t.string   "last_modified_by",     limit: 255
    t.string   "sts",                  limit: 255
    t.string   "approved_by",          limit: 100
    t.string   "language",             limit: 10
  end

  add_index "cmm_classifications", ["class"], name: "class", using: :btree
  add_index "cmm_classifications", ["datedeleted"], name: "datedeleted", using: :btree
  add_index "cmm_classifications", ["igid"], name: "igid", using: :btree
  add_index "cmm_classifications", ["legacy_description"], name: "legacy_description", length: {"legacy_description"=>333}, using: :btree
  add_index "cmm_classifications", ["long_description"], name: "long_description", length: {"long_description"=>333}, using: :btree
  add_index "cmm_classifications", ["material_id"], name: "material_id", using: :btree
  add_index "cmm_classifications", ["organization_ID"], name: "organization_ID", using: :btree
  add_index "cmm_classifications", ["short_description"], name: "short_description", length: {"short_description"=>333}, using: :btree

  create_table "cmm_rxml_references", id: false, force: :cascade do |t|
    t.string "row",                limit: 255
    t.string "Seq",                limit: 255
    t.string "igid",               limit: 255
    t.string "cat_id",             limit: 255
    t.string "INC",                limit: 255
    t.string "Class",              limit: 255
    t.string "Feature",            limit: 255
    t.string "classref",           limit: 255
    t.string "simple_propertyRef", limit: 255
    t.string "property",           limit: 255
    t.string "split_name",         limit: 255
    t.string "representation",     limit: 255
    t.string "AND_allowed",        limit: 255
    t.string "OR_allowed",         limit: 255
    t.string "representationRef",  limit: 255
    t.string "numeric_type",       limit: 255
    t.string "MRC",                limit: 255
    t.string "modecode",           limit: 255
    t.string "uom",                limit: 255
    t.string "qualifier",          limit: 255
    t.string "qualifier2",         limit: 255
    t.string "valueRef",           limit: 255
    t.string "rule",               limit: 255
    t.string "uomref",             limit: 255
    t.string "qualifierref",       limit: 255
    t.string "qualifierref2",      limit: 255
    t.string "control_value",      limit: 255
    t.string "value",              limit: 255
    t.string "value2",             limit: 255
    t.string "tname",              limit: 255
    t.string "replyCode",          limit: 255
    t.string "datecreated",        limit: 255
    t.string "datadeleted",        limit: 255
    t.string "value1",             limit: 255
    t.string "name",               limit: 255
    t.string "lastmodified",       limit: 255
  end

  add_index "cmm_rxml_references", ["Class"], name: "Class", using: :btree
  add_index "cmm_rxml_references", ["cat_id"], name: "cat_id", using: :btree

  create_table "cmm_technical_specifications", id: false, force: :cascade do |t|
    t.string   "row",                limit: 255
    t.string   "Seq",                limit: 255
    t.string   "igid",               limit: 255
    t.string   "cat_id",             limit: 255
    t.string   "INC",                limit: 255
    t.string   "material_id",        limit: 255
    t.string   "Class",              limit: 255
    t.string   "Feature",            limit: 255
    t.string   "classref",           limit: 255
    t.string   "simple_propertyRef", limit: 255
    t.string   "propertyRef",        limit: 255
    t.string   "property",           limit: 50
    t.string   "split_name",         limit: 255
    t.string   "representation",     limit: 255
    t.string   "AND_allowed",        limit: 255
    t.string   "OR_allowed",         limit: 255
    t.string   "representationRef",  limit: 255
    t.string   "numeric_type",       limit: 255
    t.string   "MRC",                limit: 255
    t.string   "modecode",           limit: 255
    t.string   "uom",                limit: 255
    t.string   "qualifier",          limit: 255
    t.string   "qualifier2",         limit: 255
    t.string   "valeRef",            limit: 255
    t.string   "rule",               limit: 255
    t.string   "uomref",             limit: 255
    t.string   "qualifierref",       limit: 255
    t.string   "qalifierref2",       limit: 255
    t.string   "control_value",      limit: 255
    t.string   "value",              limit: 255
    t.string   "abbreviate_value",   limit: 255
    t.string   "value2",             limit: 255
    t.string   "tname",              limit: 255
    t.string   "replyCode",          limit: 255
    t.datetime "datecreated"
    t.datetime "datedeleted"
    t.string   "source",             limit: 255
    t.string   "name",               limit: 255
    t.string   "lastmodified",       limit: 255
    t.string   "language",           limit: 10
  end

  add_index "cmm_technical_specifications", ["cat_id"], name: "cat_id", using: :btree
  add_index "cmm_technical_specifications", ["material_id"], name: "material_id", using: :btree

  create_table "ex_technical_specifications", force: :cascade do |t|
    t.string   "row",                limit: 255
    t.string   "Seq",                limit: 255
    t.string   "igid",               limit: 255
    t.string   "cat_id",             limit: 255
    t.string   "INC",                limit: 255
    t.string   "Class",              limit: 255
    t.string   "Feature",            limit: 255
    t.string   "classref",           limit: 255
    t.string   "simple_propertyRef", limit: 255
    t.string   "propertyRef",        limit: 255
    t.string   "split_name",         limit: 255
    t.string   "representation",     limit: 255
    t.string   "AND_allowed",        limit: 255
    t.string   "OR_allowed",         limit: 255
    t.string   "representationRef",  limit: 255
    t.string   "numeric_type",       limit: 255
    t.string   "MRC",                limit: 255
    t.string   "modecode",           limit: 255
    t.string   "uom",                limit: 255
    t.string   "qualifier",          limit: 255
    t.string   "qualifier2",         limit: 255
    t.string   "valeRef",            limit: 255
    t.string   "rule",               limit: 255
    t.string   "uomref",             limit: 255
    t.string   "qualifierref",       limit: 255
    t.string   "qalifierref2",       limit: 255
    t.string   "control_value",      limit: 255
    t.string   "value",              limit: 255
    t.string   "abbreviate_value",   limit: 255
    t.string   "value2",             limit: 255
    t.string   "tname",              limit: 255
    t.string   "replyCode",          limit: 255
    t.string   "datecreated",        limit: 255
    t.string   "datedeleted",        limit: 255
    t.string   "source",             limit: 255
    t.string   "name",               limit: 255
    t.string   "lastmodified",       limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "force_name_dis", id: false, force: :cascade do |t|
    t.string "NSN",        limit: 255
    t.string "Force_Name", limit: 255
  end

  create_table "force_names", force: :cascade do |t|
    t.string "NSN_ECCMA",  limit: 25
    t.string "Force Name", limit: 50
    t.string "Available",  limit: 5,  null: false
  end

  add_index "force_names", ["Force Name"], name: "Force Name", using: :btree
  add_index "force_names", ["NSN_ECCMA"], name: "NSN_ECCMA", using: :btree

  create_table "languages", force: :cascade do |t|
    t.integer "language_id",       limit: 4
    t.text    "controller_name",   limit: 65535, null: false
    t.string  "page_name",         limit: 255
    t.text    "language_property", limit: 65535
    t.string  "language_type",     limit: 2
    t.string  "created_at",        limit: 255
    t.string  "updated_at",        limit: 255
  end

  add_index "languages", ["language_id"], name: "language_id", using: :btree

  create_table "languages1", force: :cascade do |t|
    t.integer "language_id",       limit: 4
    t.text    "controller_name",   limit: 65535, null: false
    t.string  "page_name",         limit: 255
    t.text    "language_property", limit: 65535
    t.string  "language_type",     limit: 2
    t.string  "created_at",        limit: 255
    t.string  "updated_at",        limit: 255
  end

  add_index "languages1", ["language_id"], name: "language_id", using: :btree

  create_table "languages2", force: :cascade do |t|
    t.integer "language_id",       limit: 4
    t.text    "controller_name",   limit: 65535, null: false
    t.string  "page_name",         limit: 255
    t.text    "language_property", limit: 65535
    t.string  "language_type",     limit: 2
    t.string  "created_at",        limit: 255
    t.string  "updated_at",        limit: 255
  end

  add_index "languages2", ["language_id"], name: "language_id", using: :btree

  create_table "nsnmrcxs", force: :cascade do |t|
    t.string   "FSC",                 limit: 255
    t.string   "NIIN",                limit: 255
    t.string   "ECCMA_NSN",           limit: 255
    t.string   "MRC",                 limit: 255
    t.string   "ECCMA_Concept_ID",    limit: 255
    t.string   "ECCMA_definition_ID", limit: 50
    t.string   "ECCMA_Term_ID",       limit: 255
    t.string   "ECCMA_Term",          limit: 255
    t.string   "DMRC",                limit: 255
    t.string   "RMRC",                limit: 255
    t.string   "DMRC_old",            limit: 255
    t.string   "ECCMA_source",        limit: 255, null: false
    t.string   "ECCMA_name",          limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ECCMa_prop_val",      limit: 255, null: false
  end

  add_index "nsnmrcxs", ["ECCMA_NSN"], name: "NSN", using: :btree
  add_index "nsnmrcxs", ["MRC"], name: "MRC", using: :btree

  create_table "nsnmrcxs_1000", id: false, force: :cascade do |t|
    t.integer  "id",            limit: 4,   default: 0, null: false
    t.string   "FSC",           limit: 255
    t.string   "NIIN",          limit: 255
    t.string   "NSN",           limit: 255
    t.string   "MRC",           limit: 255
    t.string   "Concept_ID",    limit: 255
    t.string   "definition_ID", limit: 50
    t.string   "Term_ID",       limit: 255
    t.string   "Term",          limit: 255
    t.string   "DMRC",          limit: 255
    t.string   "RMRC",          limit: 255
    t.string   "DMRC_old",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "prop_val",      limit: 255,             null: false
  end

  create_table "orgs", id: false, force: :cascade do |t|
    t.integer  "id",         limit: 4
    t.integer  "factory_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "Factory",    limit: 4
  end

  create_table "reference_data", force: :cascade do |t|
    t.string   "TYPE",            limit: 255
    t.string   "FSC",             limit: 255
    t.string   "NIN",             limit: 255
    t.string   "ECCMA_NSN",       limit: 255
    t.string   "RNFC_2920",       limit: 255
    t.string   "RNCC_2910",       limit: 255
    t.string   "RNVC_4780",       limit: 255
    t.string   "DAC_2640",        limit: 255
    t.string   "RNAAC_2900",      limit: 255
    t.string   "RNSC_2923",       limit: 255
    t.string   "RNJC_2750",       limit: 255
    t.string   "CAGE_CD_9250",    limit: 255
    t.string   "REF_NBR_3570",    limit: 255
    t.text     "NAME",            limit: 16777215
    t.string   "SADC_4672",       limit: 255
    t.string   "HCC_2579",        limit: 255
    t.string   "MSDS_ID_9076",    limit: 255
    t.string   "ECCMA_TEST",      limit: 255
    t.string   "ECCMA_Country",   limit: 50
    t.string   "ECCMA_CAGE_NAME", limit: 255,      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reference_data", ["CAGE_CD_9250"], name: "CAGE_CD_9250", using: :btree
  add_index "reference_data", ["ECCMA_NSN"], name: "NSN", using: :btree
  add_index "reference_data", ["ECCMA_TEST"], name: "TEST", using: :btree

  create_table "reference_data_1000", id: false, force: :cascade do |t|
    t.integer  "id",           limit: 4,        default: 0, null: false
    t.string   "TYPE",         limit: 255
    t.string   "FSC",          limit: 255
    t.string   "NIN",          limit: 255
    t.string   "NSN",          limit: 255
    t.string   "RNFC_2920",    limit: 255
    t.string   "RNCC_2910",    limit: 255
    t.string   "RNVC_4780",    limit: 255
    t.string   "DAC_2640",     limit: 255
    t.string   "RNAAC_2900",   limit: 255
    t.string   "RNSC_2923",    limit: 255
    t.string   "RNJC_2750",    limit: 255
    t.string   "CAGE_CD_9250", limit: 255
    t.string   "REF_NBR_3570", limit: 255
    t.text     "NAME",         limit: 16777215
    t.string   "SADC_4672",    limit: 255
    t.string   "HCC_2579",     limit: 255
    t.string   "MSDS_ID_9076", limit: 255
    t.string   "TEST",         limit: 255
    t.string   "Country",      limit: 50
    t.string   "CAGE_NAME",    limit: 255,                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "source_cagec", id: false, force: :cascade do |t|
    t.string "cagec", limit: 255
  end

  create_table "source_data", force: :cascade do |t|
    t.string   "FSC",                       limit: 255
    t.string   "NIIN",                      limit: 255
    t.string   "ECCMA_NSN",                 limit: 255
    t.string   "SDC",                       limit: 255
    t.string   "UI",                        limit: 255
    t.string   "SHORT_NOMENCLATURE",        limit: 255
    t.string   "PART_NUMBER",               limit: 255
    t.string   "CAGEC",                     limit: 255
    t.string   "EIC",                       limit: 255
    t.string   "EI_FSC",                    limit: 255
    t.string   "NIIN2",                     limit: 255
    t.string   "MANUFACTURER_MAKE_MODEL",   limit: 255
    t.string   "REQ_QTY",                   limit: 255
    t.string   "NAME",                      limit: 255
    t.string   "NSN_Name",                  limit: 255
    t.string   "CAGE_PN",                   limit: 255
    t.string   "END_ITEM_APPLICATION",      limit: 255
    t.string   "DIC",                       limit: 255
    t.string   "DOC",                       limit: 255
    t.string   "QTY",                       limit: 255
    t.string   "PRICE",                     limit: 255
    t.string   "FORCE_NAME",                limit: 255
    t.string   "STOCK_NUMBER",              limit: 255
    t.string   "SOS",                       limit: 255
    t.string   "NUMBER_OF_PARTS_IN_SUPPLY", limit: 255
    t.string   "MTC",                       limit: 255
    t.string   "FILE_NAME",                 limit: 255
    t.string   "NIIN_ECCMA",                limit: 255
    t.string   "FSC_ECCMA",                 limit: 255
    t.string   "COUNTRY_ECCMA",             limit: 255
    t.string   "SHRT_NM_2301_ECCMA",        limit: 255
    t.string   "INC_4080_ECCMA",            limit: 255
    t.string   "ECCMA_valid",               limit: 10
    t.text     "Name_Eccma",                limit: 16777215
    t.string   "ECCMA_Status",              limit: 100
    t.string   "ECCMA_FLAG",                limit: 25
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ECCMA_Cleansed",            limit: 255,      null: false
  end

  add_index "source_data", ["CAGEC"], name: "CAGEC", using: :btree
  add_index "source_data", ["ECCMA_Cleansed"], name: "Cleansed", using: :btree
  add_index "source_data", ["ECCMA_FLAG"], name: "FLAG", using: :btree
  add_index "source_data", ["ECCMA_NSN"], name: "NSN", using: :btree
  add_index "source_data", ["ECCMA_Status"], name: "Status", using: :btree
  add_index "source_data", ["FORCE_NAME"], name: "FORCE_NAME", using: :btree
  add_index "source_data", ["PART_NUMBER"], name: "PART_NUMBER", using: :btree

  create_table "source_data_1000", id: false, force: :cascade do |t|
    t.integer  "id",                        limit: 4,        default: 0, null: false
    t.string   "FSC",                       limit: 255
    t.string   "NIIN",                      limit: 255
    t.string   "NSN",                       limit: 255
    t.string   "SDC",                       limit: 255
    t.string   "UI",                        limit: 255
    t.string   "SHORT_NOMENCLATURE",        limit: 255
    t.string   "PART_NUMBER",               limit: 255
    t.string   "CAGEC",                     limit: 255
    t.string   "EIC",                       limit: 255
    t.string   "EI_FSC",                    limit: 255
    t.string   "NIIN2",                     limit: 255
    t.string   "MANUFACTURER_MAKE_MODEL",   limit: 255
    t.string   "REQ_QTY",                   limit: 255
    t.string   "NAME",                      limit: 255
    t.string   "NSN_Name",                  limit: 255
    t.string   "CAGE_PN",                   limit: 255
    t.string   "END_ITEM_APPLICATION",      limit: 255
    t.string   "DIC",                       limit: 255
    t.string   "DOC",                       limit: 255
    t.string   "QTY",                       limit: 255
    t.string   "PRICE",                     limit: 255
    t.string   "FORCE_NAME",                limit: 255
    t.string   "STOCK_NUMBER",              limit: 255
    t.string   "SOS",                       limit: 255
    t.string   "NUMBER_OF_PARTS_IN_SUPPLY", limit: 255
    t.string   "MTC",                       limit: 255
    t.string   "FILE_NAME",                 limit: 255
    t.string   "NIIN_ECCMA",                limit: 255
    t.string   "FSC_ECCMA",                 limit: 255
    t.string   "COUNTRY_ECCMA",             limit: 255
    t.string   "SHRT_NM_2301_ECCMA",        limit: 255
    t.string   "INC_4080_ECCMA",            limit: 255
    t.string   "valid",                     limit: 10
    t.text     "Name_Eccma",                limit: 16777215
    t.string   "Status",                    limit: 100
    t.string   "FLAG",                      limit: 25
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "source_data_bk", force: :cascade do |t|
    t.string   "FSC",                       limit: 255
    t.string   "NIIN",                      limit: 255
    t.string   "NSN",                       limit: 255
    t.string   "SDC",                       limit: 255
    t.string   "UI",                        limit: 255
    t.string   "SHORT_NOMENCLATURE",        limit: 255
    t.string   "PART_NUMBER",               limit: 255
    t.string   "CAGEC",                     limit: 255
    t.string   "EIC",                       limit: 255
    t.string   "EI_FSC",                    limit: 255
    t.string   "NIIN2",                     limit: 255
    t.string   "MANUFACTURER_MAKE_MODEL",   limit: 255
    t.string   "REQ_QTY",                   limit: 255
    t.string   "NAME",                      limit: 255
    t.string   "NSN_Name",                  limit: 255
    t.string   "CAGE_PN",                   limit: 255
    t.string   "END_ITEM_APPLICATION",      limit: 255
    t.string   "DIC",                       limit: 255
    t.string   "DOC",                       limit: 255
    t.string   "QTY",                       limit: 255
    t.string   "PRICE",                     limit: 255
    t.string   "FORCE_NAME",                limit: 255
    t.string   "STOCK_NUMBER",              limit: 255
    t.string   "SOS",                       limit: 255
    t.string   "NUMBER_OF_PARTS_IN_SUPPLY", limit: 255
    t.string   "MTC",                       limit: 255
    t.string   "FILE_NAME",                 limit: 255
    t.string   "NIIN_ECCMA",                limit: 255
    t.string   "FSC_ECCMA",                 limit: 255
    t.string   "COUNTRY_ECCMA",             limit: 255
    t.string   "SHRT_NM_2301_ECCMA",        limit: 255
    t.string   "INC_4080_ECCMA",            limit: 255
    t.string   "valid",                     limit: 10
    t.text     "Name_Eccma",                limit: 16777215
    t.string   "Status",                    limit: 100
    t.string   "FLAG",                      limit: 25
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "source_data_bk", ["CAGEC"], name: "CAGEC", using: :btree
  add_index "source_data_bk", ["FLAG"], name: "FLAG", using: :btree
  add_index "source_data_bk", ["FORCE_NAME"], name: "FORCE_NAME", using: :btree
  add_index "source_data_bk", ["NSN"], name: "NSN", using: :btree
  add_index "source_data_bk", ["PART_NUMBER"], name: "PART_NUMBER", using: :btree
  add_index "source_data_bk", ["Status"], name: "Status", using: :btree

  create_table "source_data_cage_matches", force: :cascade do |t|
    t.string  "cagec", limit: 50
    t.integer "cou",   limit: 4,  default: 0, null: false
  end

  add_index "source_data_cage_matches", ["cagec"], name: "cagec", using: :btree
  add_index "source_data_cage_matches", ["cou"], name: "cou", using: :btree

  create_table "source_data_cages", force: :cascade do |t|
    t.string  "CAGEC", limit: 50
    t.integer "cou",   limit: 4
  end

  add_index "source_data_cages", ["CAGEC"], name: "CAGEC", using: :btree
  add_index "source_data_cages", ["cou"], name: "cou", using: :btree

  create_table "technical_specifications", force: :cascade do |t|
    t.string   "row",                limit: 255
    t.string   "Seq",                limit: 255
    t.string   "igid",               limit: 255
    t.string   "cat_id",             limit: 255
    t.string   "INC",                limit: 255
    t.string   "material_id",        limit: 255
    t.string   "Class",              limit: 255
    t.string   "Feature",            limit: 255
    t.string   "classref",           limit: 255
    t.string   "simple_propertyRef", limit: 255
    t.string   "propertyRef",        limit: 255
    t.string   "split_name",         limit: 255
    t.string   "representation",     limit: 255
    t.string   "AND_allowed",        limit: 255
    t.string   "OR_allowed",         limit: 255
    t.string   "representationRef",  limit: 255
    t.string   "numeric_type",       limit: 255
    t.string   "MRC",                limit: 255
    t.string   "modecode",           limit: 255
    t.string   "uom",                limit: 255
    t.string   "qualifier",          limit: 255
    t.string   "qualifier2",         limit: 255
    t.string   "valeRef",            limit: 255
    t.string   "rule",               limit: 255
    t.string   "uomref",             limit: 255
    t.string   "qualifierref",       limit: 255
    t.string   "qalifierref2",       limit: 255
    t.string   "control_value",      limit: 255
    t.string   "value",              limit: 255
    t.string   "abbreviate_value",   limit: 255
    t.string   "value2",             limit: 255
    t.string   "tname",              limit: 255
    t.string   "replyCode",          limit: 255
    t.string   "datecreated",        limit: 255
    t.string   "datedeleted",        limit: 255
    t.string   "source",             limit: 255
    t.string   "name",               limit: 255
    t.string   "lastmodified",       limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255
    t.string   "encrypted_password",     limit: 255
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",        limit: 4
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "Organization_name",      limit: 255
    t.string   "Organization_ID",        limit: 255
    t.string   "Individual_ID",          limit: 255
    t.integer  "level",                  limit: 4
    t.string   "designation",            limit: 255
    t.integer  "role",                   limit: 4
    t.integer  "approved",               limit: 4
    t.string   "image",                  limit: 255
    t.boolean  "admin",                              default: false
  end

  add_index "users", ["email"], name: "email", using: :btree
  add_index "users", ["reset_password_token"], name: "reset_password_token", using: :btree

end
