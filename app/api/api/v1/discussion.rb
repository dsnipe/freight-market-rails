module API
  module V1
    class Discussion < Grape::API

      namespace :discussions do
        resource :conversations do
          desc "Return conversations of current user."
          get do
            { conversations: [] }
          end

          desc "Return messages for specific conversation."
          params do
            requires :id, type: String, desc: "Conversation Id."
          end
          get ':id' do
            messages = ::Discussion::Conversation.find(params[:id]).messages
            { messages: messages, conversation_id: params[:id] }
          end

          desc 'Send offer to opponent.'
          params do
            requires :caller_position_id, type: String, desc: "Position Id for caller."
            requires :receiver_position_id, type: String, desc: "Position Id for receiver."
            requires :caller_position_type, type: String, desc: "Type of current position."
            optional :message, type: String, desc: "Optional message for offer."
          end
          post 'offer' do
            service = ::Discussion::ConversationFactory.new(declared(params))

            service.on(:succesful) do |result|
              body result
            end

            service.on(:error) do |error|
              error!(errors.to_json, 400)
            end

            service.save
          end

          desc "Send message to conversation."
          params do
            requires :conversation_id, type: String, desc: "Conversation Id."
            requires :body, type: String, desc: "Message body."
            requires :owner_id, type: String, desc: "Owner of message Id."
          end
          post "message" do
            service = ::Discussion::Conversation.find(params[:conversation_id])

            service.on :message_sent do |result|
              body result
            end

            service.add_message(params[:body], params[:owner_id])
          end
        end
      end

    end
  end
end
