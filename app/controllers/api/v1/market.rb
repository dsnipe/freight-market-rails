module API
  module V1
    class Market < Grape::API
      include API::V1::Defaults

      resource :positions do
        resource :vessels do
          desc 'Create vessel position.'
          params do
            requires :open_date, type: Date, desc: "Date where position open."
            requires :close_date, type: Date, desc: "Date where position close."
            requires :dwcc, type: Integer, desc: "DWCC for cargo."
            requires :title, type: String, desc: "Vessel title."
          end
          post do
            { status: 'ok' }
          end

          desc 'List of vessel positions.'
          get do
            { positions_vessel: [] }
          end

          desc "Get cargo position by Id."
          get ":id" do
            { position_vessel: {} }
          end

          desc 'Find matches for given cargo.'
          params do
            requires :cargo_id, type: String, desc: "Vessel Id."
          end
          get ':vessel_id' do
            { position_vessels: [], cargo_id: params[:vessel_id] }
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
            { status: 'ok' }
          end

          desc 'Get list of cargo positions.'
          get do
            { positions_cargo: [] }
          end

          desc 'Find matches for given cargo.'
          params do
            requires :cargo_id, type: String, desc: "Cargo Id."
          end
          get ':cargo_id' do
            { position_vessels: [], cargo_id: params[:cargo_id] }
          end

        end
      end
    end
  end
end
