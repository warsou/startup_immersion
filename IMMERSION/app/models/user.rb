class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :situation, optional: true
  belongs_to :activity, optional: true
  belongs_to :newsletter, optional: true
  has_many :attendances
  has_many :events, through: :attendances

  has_one_attached :avatar

  after_create :welcome_send
  def welcome_send
  	UserMailer.welcome_email(self).deliver_now
  end


  after_create :check_newsletter
  def check_newsletter
    existing_newsletter = Newsletter.find_by(email: self.email)
    if existing_newsletter != nil
      self.update!(newsletter: existing_newsletter)
    end
  end
end
