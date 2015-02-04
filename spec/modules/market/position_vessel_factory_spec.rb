require "rails_helper"

RSpec.describe Market::PositionVesselFactory do

  before(:each) do
    @pos_ves_attr = FactoryGirl.attributes_for(:position_vessel)
    @ves_attr = FactoryGirl.attributes_for(:vessel)
  end

  it "should create position vessel and vessel" do
    res = Market::PositionVesselFactory.new(@pos_ves_attr.merge(@ves_attr)).save
    expect(res).to_not be_nil
    expect(res.errors.size).to eq(0)
  end

  it "should raise error" do
    expect {
      Market::PositionVesselFactory.new({}).save
    }.to raise_error(ArgumentError)
  end

  it "should return object with error" do
    @ves_attr.reject! {|k,v| k == :dwcc}
    res = Market::PositionVesselFactory.new(@pos_ves_attr.merge(@ves_attr)).save
    expect(res.errors.size).to eq(2)
  end
end
