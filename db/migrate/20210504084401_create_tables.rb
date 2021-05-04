class CreateTables < ActiveRecord::Migration[6.1]
  def change
    create_table "assessments" do |t|
      t.integer "user_id", null: false
      t.integer "exam_id", null: false
      t.integer "college_id", null: false
      t.datetime "start_time"

      t.timestamps
    end
  
    create_table "colleges" do |t|
      t.string "name"

      t.timestamps
    end
  
    create_table "exam_windows" do |t|
      t.datetime "window_start"
      t.datetime "window_end"
      t.integer "exam_id"
      t.integer "status"

      t.timestamps
    end
  
    create_table "exams" do |t|
      t.string "name"
      t.integer "college_id"
      t.integer "level", default: 1

      t.timestamps
    end
  
    create_table "users" do |t|
      t.string "first_name"
      t.string "last_name"
      t.string "phone_number", null: false, unique: true
      t.integer "level", default: 1

      t.timestamps
    end

    create_table "api_requests" do |t|
      t.string "endpoint"
      t.string "remote_ip"
      t.integer "status"
      t.text "payload"
      t.text "request_errors"
      t.datetime "created_at"
    end
  end
end
