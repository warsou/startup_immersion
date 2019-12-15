class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :motivation,
  presence: true,
  length: {in: 20..1000, message: ' must be between 20 and 1000 characters long'}

  validates :comment,
  presence: true,
  length: {in: 20..1000, message: ' must be between 20 and 1000 characters long'}
end
