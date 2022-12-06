class TeacherComment < ApplicationRecord
  belongs_to :activity
  belongs_to :student, class_name: 'User', foreign_key: :student_id
  belongs_to :teacher, class_name: 'User', foreign_key: :teacher_id
end
