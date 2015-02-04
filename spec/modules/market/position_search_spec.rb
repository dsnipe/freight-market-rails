require 'rails_helper'

RSpec.describe Market::SearchPosition do

  before(:each) do
    @pos_cargo  = FactoryGirl.create('position_cargo')
    @pos_cargo2 = FactoryGirl.create('position_cargo', dwcc: 10)
    @pos_vessel = FactoryGirl.create('position_vessel')
  end

  it "should find cargo position for vessel position" do
    result = Market::SearchPosition.find_matches_for(@pos_vessel)
    expect(result.size).to eq(1)
    expect(result[0]).to eq(@pos_cargo)
  end

  it "should find vessel position for cargo position" do
    result = Market::SearchPosition.find_matches_for(@pos_cargo)
    expect(result.length).to eq(1)
    expect(result[0]).to eq(@pos_vessel)
  end

  it "should search by params for cargo positions" do
    result = Market::SearchPosition.by_params_for_cargo_positions({dwcc: 10})
    expect(result.size).to eq(1)
    expect(result.first).to eq(@pos_cargo2)
  end

  it "should search by params for vessel positions" do
    result = Market::SearchPosition.by_params_for_vessel_positions({dwcc: 3000})
    expect(result.size).to eq(1)
    expect(result.first).to eq(@pos_vessel)
  end

  it "should return empty array if nothing finded" do
    result = Market::SearchPosition.by_params_for_vessel_positions({dwcc: 2000})
    expect(result.size).to eq(0)
  end

  it "should return raise Error if not give params in params search" do
    expect {
      Market::SearchPosition.by_params_for_vessel_positions({})
    }.to raise_error(ArgumentError)
  end

end
