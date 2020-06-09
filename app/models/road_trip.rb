class RoadTrip < ApplicationRecord
  validates :origin, presence: true
  validates :destination, presence: true
  validates :travel_time, presence: true
  validates :temp, presence: true
  validates :weather_summary, presence: true
  belongs_to :user
end
