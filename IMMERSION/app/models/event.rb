class Event < ApplicationRecord
  
  belongs_to :startup
  has_many :attendances
  has_many :users, through: :attendances
  
  geocoded_by :adress
  after_validation :geocode, if: :adress_changed?
  
  validates :title,
  presence: true,
  length: {in: 1..140, message: ' must be between 1 and 140 characters long'}

  validates :start_datetime,
  presence: true
  validate :start_datetime_ok?

  validates :duration,
  presence: true
  validate :duration_modulo_5?

  validates :description,
  presence: true,
  length: {in: 20..1000, message: ' must be between 20 and 1000 characters long'}

  validates :short_location,
  presence: true,
  length: {in: 1..140, message: ' must be between 1 and 140 characters long'}

  validates :adress,
  presence: true,
  length: {in: 1..140, message: ' must be between 1 and 140 characters long'}

  validates :zip_code,
  presence: true,
  numericality: { greater_than: 9999, less_than: 100000, message: ' must be between 9999 and  100000'}

  validates :city,
  presence: true,
  length: {in: 1..140, message: ' must be between 5 and 140 characters long'}
  
  def self.search(params)
    @parameter = params[:search].downcase
    events = Event.where("lower(title) LIKE ? or lower(description) LIKE ? or lower(short_location) LIKE ?", "%#{@parameter}%","%#{@parameter}%","%#{@parameter}%") if params[:search].present?
    events
  end
  
  def end_date
  	return start_datetime + (duration * 60)
  end

  private

  def start_datetime_ok?
  	errors.add(:start_datetime, " can't be in the past") unless
  	start_datetime.present? && start_datetime > Date.today
  end

  def duration_modulo_5?
  	errors.add(:duration, " must be positive and a multiple of 5") unless
  	duration.to_i % 5 == 0 && duration.to_i > 0
  end
end
