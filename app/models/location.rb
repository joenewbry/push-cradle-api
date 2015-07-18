class Location < ActiveRecord::Base
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :created_at, presence: true
  validates :saved_at, presence: true
  validates :unique_id, presence: true
  validates :idfa, presence: true

  belongs_to  :device, foreign_key: "idfa", class_name: "Device"
end
