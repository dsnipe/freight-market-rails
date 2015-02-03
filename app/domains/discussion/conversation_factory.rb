# @input: caller, receiver, caller_position, receiver_position
# Creation steps:
# - create message for conversation
# - preapare and store positions states
# - Send notification after success save

class Discussion::ConversationFactory
  attr_accessor :caller, :caller_position, :receiver, :receiver_position, :message
  attr_reader :conversation_instance, :message_instance

  def initialize(args={})
    args.each do |key, val|
      send("#{key}=", val)
    end
  end

  def save
    validate_arguments
    init_conversation
    create_message
    store_positions
    connect_postions
    finialize_save
  end

  private

    def init_conversation
      @conversation_instance = Discussion::Conversation.new
    end

    def create_message
      body = @message ? @message : 'Offer pending message'
      @message_instance = Discussion::Message.new({body: body})
    end

    def store_positions
      @conversation_instance.caller_init_state = JSON.parse(@caller_position.to_json)
      @conversation_instance.receiver_init_state = JSON.parse(@receiver_position.to_json)
    end

    def connect_postions
      if @caller_position.position_type == 'position_cargo'
        pos_cargo = @caller_position
        pos_vessel = @receiver_position
      else
        pos_cargo = @receiver_position
        pos_vessel = @caller_position
      end
      conversation_instance.messages.push(@message_instance)
      @conversation_instance.position_cargo = pos_cargo
      @conversation_instance.position_vessel = pos_vessel
    end

    def finialize_save
      @conversation_instance.caller = @caller
      @conversation_instance.receiver = @receiver
      if @conversation_instance.save({ state: :offered })
        # Send notification, etc.
        @conversation_instance
      end
    end

    def validate_arguments
      %w(caller caller_position receiver receiver_position).each do |var|
        unless instance_variables.include? :"@#{var}"
          raise ArgumentError.new("There is no '#{var}' in #{self.class}")
        end
      end
    end

end
