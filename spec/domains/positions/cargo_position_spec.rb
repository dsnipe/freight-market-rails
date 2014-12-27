require 'rails_helper'

RSpec.describe CargoPosition do
	let(:cargo_position) { FactoryGirl.create(:cargo_position) }

	it { is_expected.to enumerize(:state).in(:active, :closed) }
	it { expect(cargo_position).not_to be_nil  }
	it { expect(cargo_position.sf).to eq(50) }
end