require 'spec_helper'

RSpec.describe Device, type: :model do
  it { should validate_presence_of(:idfa) }
end
