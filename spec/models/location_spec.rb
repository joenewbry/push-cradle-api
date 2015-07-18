# spec/model/location_spec.rb
#
require 'spec_helper'

describe Location, 'Validations' do
  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }
  it { should validate_presence_of(:created_at) }
  it { should validate_presence_of(:saved_at) }
  it { should validate_presence_of(:unique_id) }
  it { should validate_presence_of(:idfa) }
end

describe Location, 'Associations' do
  it { should belong_to(:device).class_name('Device') }
end

