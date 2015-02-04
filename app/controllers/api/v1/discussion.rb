module API
  module V1
    class Discussion < Grape::API
      include API::V1::Defaults

      resource :conversations do
        desc "Return messages for specific conversation."
        params do
          requires :id, type: Integer, desc: "Conversation Id."
        end
        get ':id' do
          { conversations: [] }
        end

        desc 'Send offer to opponent.'
        params do
          requires :current_position_id, type: String, desc: "Position Id for caller."
          requires :oponent_position_id, type: String, desc: "Position Id for receiver."
          optional :message, type: String, desc: "Optional message for offer"
        end
        post 'offer' do
          { status: 'ok' }
        end

        desc "Send message to conversation."
        params do
          requires :conversation_id, type: String, desc: "Conversation Id."
        end
        post "message" do
          { status: 'ok' }
        end
      end

    end
  end
end
