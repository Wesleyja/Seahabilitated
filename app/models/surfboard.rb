class Surfboard < ApplicationRecord
  # collections for validation and user input

  CATEGORY = %w[Shortboard Longboard Funboard Hybrid Other]
  SKILL_LEVEL = ["Beginner", "Up To Intermediate", "up To Advanced", "Up To Expert"]
  WAVE_SIZE = ["Up to 3ft", "Up to 5ft", "Up to 7ft", "Up to 10ft", "Up to and more than 10ft"]
  WAVE_TYPE = %w[Reef Pointbreak Beachbreak]
  FIN_TYPE = ['Single-fin', 'Twin', 'Tri/thruster', 'Quad', 'Other']

  # associations
  belongs_to :user
  has_many :bookings
  # has_many :users, through: :bookings
  reverse_geocoded_by :longitude, :latitude, address: :location
  after_validation :reverse_geocode

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  has_one_attached :photo

  # # validations
  validates :brand, presence: true
  validates :price, presence: true, numericality: true
  validates :photo, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORY }
  validates :title, presence: true
  validates :description, presence: true
  validates :wave_type, presence: true, inclusion: { in: WAVE_TYPE }
  validates :board_dimensions, presence: true
  validates :fin_type, presence: true, inclusion: { in: FIN_TYPE }
  validates :deposit, presence: true, numericality: true
  validates :skill_level, presence: true, inclusion: { in: SKILL_LEVEL }
  validates :wave_size, presence: true, inclusion: { in: WAVE_SIZE }

  # methods to return array for simpleform
  def cat
    CATEGORY
  end

  def skilllev
    SKILL_LEVEL
  end

  def wavesize
    WAVE_SIZE
  end

  def wavetype
    WAVE_TYPE
  end

  def fintype
    FIN_TYPE
  end

  # for flatpicker
  def unavailable_dates
    bookings.pluck(:start_date, :end_date).map do |range|
      { from: range[0], to: range[1] }
    end
  end
end
