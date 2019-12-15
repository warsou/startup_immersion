class Newsletter < ApplicationRecord
  has_one :user

  validates :email,
  presence: true

  after_create :check_user
  def check_user
    existing_user = User.find_by(email: self.email)
    if existing_user != nil
      existing_user.update!(newsletter: self)
    end
  end
end
