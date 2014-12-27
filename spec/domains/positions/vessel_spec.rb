require 'rails_helper'

RSpec.describe Vessel do
	let(:vessel) { FactoryGirl.create(:vessel) }

	it { expect(vessel).not_to be_nil }
end
