class Device < ActiveRecord::Base
  validates :idfa, presence: true
end
