module API
  module V1
    class Market < Grape::API

      resource :positions do
        resource :vessels do
          desc 'Create vessel position.'
          params do
            requires :open_date, type: Date, desc: "Date where position open."
            requires :close_date, type: Date, desc: "Date where position close."
            requires :dwcc, type: Integer, desc: "DWCC for vessel."
            requires :title, type: String, desc: "Vessel title."
          end
          post do
            service = ::Market::PositionVesselFactory.new(declared(params))

            service.on(:succesful) do |result|
              body result
            end

            service.on(:error) do |errors|
              error!(errors.to_json, 400)
            end

            service.save
          end

          desc 'List of vessel positions.'
          get do
            { positions_vessel: ::Market::PositionVessel.all }
          end

          desc "Get cargo position by Id."
          params do
            requires :vessel_id, type: String, desc: "Cargo positions Id."
          end
          get ":vessel_id" do
            { position_vessel: ::Market::PositionVessel.find(params[:vessel_id]) }
          end

          desc 'Find matches for given cargo.'
          params do
            requires :vessel_id, type: String, desc: "Vessel Id."
          end
          get 'match/:vessel_id' do
            pos_vessel = ::Market::PositionVessel.find(params[:vessel_id])
            pos_cargos = ::Market::SearchPosition.find_matches_for(pos_vessel)
            { positions_cargo: pos_cargos, vessel_id: params[:vessel_id] }
          end
        end

        resource :cargos do
          desc 'Create cargo position.'
          params do
            requires :open_date, type: Date, desc: "Date where position open."
            requires :close_date, type: Date, desc: "Date where position close."
            requires :dwcc, type: Integer, desc: "DWCC for cargo"
          end
          post do
            service = ::Market::PositionCargoFactory.new(declared(params))

            service.on(:succesful) do |result|
              body result
            end

            service.on(:error) do |errors|
              error!(errors.to_json, 400)
            end

            service.save
          end

          desc 'Get list of cargo positions.'
          get do
            {positions_cargo: ::Market::PositionCargo.all}
          end

          desc 'Find matches for given cargo.'
          params do
            requires :cargo_id, type: String, desc: "Cargo Id."
          end
          get 'match/:cargo_id' do
            pos_cargo = ::Market::PositionCargo.find(params[:cargo_id])
            pos_vessels = ::Market::SearchPosition.find_matches_for(pos_cargo)
            { positions_vessel: pos_vessels, cargo_id: params[:cargo_id] }
          end

        end

        desc 'Get list of positions.'
        get do
          pos_cargos = ::Market::PositionCargo.all
          pos_vessels = ::Market::PositionVessel.all
          {positions_cargo: pos_cargos, positions_vessel: pos_vessels}
        end
      end
    end
  end
end
