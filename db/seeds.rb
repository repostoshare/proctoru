# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def output_attributes(item)
  item.attributes.except("created_at", "updated_at")
end

college_1 = College.create(name: "Proctor University")
college_2 = College.create(name: "Yardstick University")

current_level_1_exam = Exam.create(name: "Javascript Level 1 Test", college: college_1)
old_level_1_exam = Exam.create(name: "Ruby Level 1 Test", college: college_1)
current_level_2_exam = Exam.create(name: "Javascript Level 2 Test", college: college_2, level: 2)

current_level_1_exam_window = ExamWindow.create(window_start: (Time.now - 1.week),
                                                window_end: (Time.now + 1.day),
                                                status: "active",
                                                exam: current_level_1_exam)

old_level_1_exam_window = ExamWindow.create(window_start: (Time.now - 1.week),
                                            window_end: (Time.now - 2.day),
                                            status: "active",
                                            exam: old_level_1_exam)

current_level_2_exam_window = ExamWindow.create(window_start: (Time.now - 1.week),
                                                window_end: (Time.now + 1.day),
                                                status: "active",
                                                exam: current_level_2_exam)

existing_level_1_user = User.create(first_name: "Michael", last_name: "Scott", phone_number: "0987654321", level: 1 )
existing_level_2_user = User.create(first_name: "Scott", last_name: "McFarland", phone_number: "1234567890", level: 2 )

puts "*************************************************"
puts "Below is the seeded data you can use for testing"
puts "*************************************************"
puts "."
puts "."
puts "."
puts "College 1", output_attributes(college_1)
puts "."
puts "College 2", output_attributes(college_2)
puts "."

puts "Current Level 1 Exam", output_attributes(current_level_1_exam)
puts "."
puts "Old Level 1 Exam", output_attributes(old_level_1_exam)
puts "."
puts "Current Level 2 Exam", output_attributes(current_level_2_exam)
puts "."

puts "Existing Level 1 User", output_attributes(existing_level_1_user)
puts "."
puts "Existing Level 2 User", output_attributes(existing_level_2_user)
puts "."

puts "Current Time (For use with 'start_time' parameter", Time.now
puts "."

puts "DATABASE HAS BEEN SEEDED"