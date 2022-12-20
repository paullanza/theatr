class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :badges
  has_many :user_responses
  has_many :teacher_comments, foreign_key: :teacher_id
  has_many :teacher_comments, foreign_key: :student_id
  belongs_to :classroom

  validates :access_code, presence: true

  before_save :validate_access_code
  after_create :generate_classroom

  def validate_access_code
    if self.access_code == "placeholderTC"
      self.teacher = true
    else
      # get all Classrooms access_codes and check if access code entered is one of them
      # if yes, self.classroom = that classroom
      # if not, access code is incorrect
    end
  end

  def generate_classroom
    if self.teacher == true
      classroom = Classroom.create!(date: DateTime.new(2022, 12, 14, 5, 30))
      classroom.access_code = "class##{classroom.id}"
      classroom.save!
      self.classroom = classroom
    end
  end
end
