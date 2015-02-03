require 'rails_helper'

RSpec.describe Market::PositionCargo do
	let(:position_cargo) { FactoryGirl.create(:position_cargo) }

	it { is_expected.to enumerize(:state).in(:active, :closed) }
	it { expect(position_cargo).not_to be_nil  }
	it { expect(position_cargo.sf).to eq(50) }
end
