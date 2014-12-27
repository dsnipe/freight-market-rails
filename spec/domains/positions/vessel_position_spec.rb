require 'rails_helper'

RSpec.describe VesselPosition do
  let(:vessel_position) { FactoryGirl.create(:vessel_position) }

  it { expect(vessel_position).to_not be_nil }
end