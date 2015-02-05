require "rails_helper"

describe "Market API" do

  before(:each) do
    @data = {
      open_date: '2015-03-01T00:00:00',
      close_date: '2015-03-10T00:00:00',
      dwcc: '3000'
    }

    # Auth stubbing
    Grape::Endpoint.before_each do |endpoint|
      allow(endpoint).to receive(:authenticated).and_return(true)
    end
  end

  after do
    Grape::Endpoint.before_each nil
  end

  def prepare_record(record)
    JSON.parse(record.to_json, symbolize_names: true)
  end

  it "should return list of cargos and vessels" do
    get '/api/positions'
    pos_cargos = prepare_record(::Market::PositionCargo.all)
    pos_vessels = prepare_record(::Market::PositionVessel.all)
    expect_json({positions_vessel: pos_vessels, positions_cargo: pos_cargos})
  end

  describe "for cargo position" do
    it "should create it" do
      post '/api/positions/cargos', @data, format: :json
      expect_json(prepare_record(::Market::PositionCargo.last))
    end

    it "should return errors" do
      @data[:dwcc] = 'letters'
      post '/api/positions/cargos', @data, format: :json
      expect_status("400")
      expect_json_keys('error', [:message])
    end

    it "should return list of them" do
      10.times { FactoryGirl.create(:position_cargo) }
      pos_cargos = prepare_record(::Market::PositionCargo.all)
      get '/api/positions/cargos'
      expect_json({positions_cargo: prepare_record(pos_cargos)})
    end

    it "should return matches for given position" do
      2.times { FactoryGirl.create(:position_vessel) }
      pos_cargo = FactoryGirl.create(:position_cargo)
      get "/api/positions/cargos/match/#{pos_cargo.id}"
      pos_vessels = ::Market::SearchPosition.find_matches_for(pos_cargo)
      expect_json({positions_vessel: prepare_record(pos_vessels),
                   cargo_id: pos_cargo.id.to_s})
    end
  end

  describe "for vessel positions" do

    it "should create vessel" do
      correct_data = @data.merge({title: 'Some vessel'})
      post '/api/positions/vessels', correct_data, format: :json
      expect_json prepare_record(::Market::PositionVessel.last)
    end

    it "should return list" do
      10.times { FactoryGirl.create(:position_vessel) }
      pos_vessels = prepare_record(::Market::PositionVessel.all)
      get '/api/positions/vessels'
      expect_json({positions_vessel: pos_vessels})
    end

    it "should return one by Id" do
      pos_vessel = FactoryGirl.create(:position_vessel)
      get "/api/positions/vessels/#{pos_vessel.id}"
      expect_json({position_vessel: prepare_record(pos_vessel)})
    end

    it "should return matches for given position" do
      2.times { FactoryGirl.create(:position_cargo) }
      pos_vessel = FactoryGirl.create(:position_vessel)
      get "/api/positions/vessels/match/#{pos_vessel.id}"
      pos_cargos = ::Market::SearchPosition.find_matches_for(pos_vessel)
      expect_json({positions_cargo: prepare_record(pos_cargos),
                   vessel_id: pos_vessel.id.to_s})
    end
  end

end
