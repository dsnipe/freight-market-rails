require 'rails_helper'

RSpec.describe Market::PositionVessel do
  let(:position_vessel) { FactoryGirl.create(:position_vessel) }

  it { expect(position_vessel).to_not be_nil }
end
