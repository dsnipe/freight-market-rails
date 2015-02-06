# @input: caller, receiver, caller_position, receiver_position
# Creation steps:
# - create message for conversation
# - preapare and store positions states
# - Send notification after success save

class Discussion::ConversationFactory
  include Wisper::Publisher

  attr_accessor :caller_position_id, :position_cargo, :receiver_position_id,
                :position_vessel, :message, :caller_position_type
  attr_reader :conversation

  def initialize(args={})
    args.each do |key, val|
      send("#{key}=", val)
    end
  end

  def save
    validate_arguments
    init_conversation
    define_positions
    create_message
    finialize_save
  end

  private

    def isCargoCaller?
      @caller_position_type == 'position_cargo'
    end

    def isVesselCaller?
      !isCargoCaller?
    end

    def init_conversation
      @conversation = Discussion::Conversation.new
    end

    def create_message
      body = @message ? @message : 'Offer pending message'
      @conversation.add_message(body, @conversation.user_caller.id)
    end

    def define_positions
      if isCargoCaller?
        set_position_vars(pos_carg_id: @caller_position_id, pos_ves_id: @receiver_position_id)
        init_positions_states(caller_pos: @position_cargo, receiver_pos: @position_vessel)
      else
        set_position_vars(pos_carg_id: @receiver_position_id, pos_ves_id: @caller_position_id)
        init_positions_users(caller_pos: @position_vessel, receiver_pos: @position_cargo)
      end
    end

    def set_position_vars(pos_carg_id: , pos_ves_id: )
      @position_cargo = ::Market::PositionCargo.find(pos_carg_id)
      @position_vessel = ::Market::PositionVessel.find(pos_ves_id)
      @conversation.position_cargo = @position_cargo
      @conversation.position_vessel = @position_vessel
    end

    def init_positions_users(caller_pos: , receiver_pos: )
      @conversation.caller_init_state = JSON.parse(caller_pos.to_json)
      @conversation.receiver_init_state = JSON.parse(receiver_pos.to_json)
      @conversation.user_caller = caller_pos.user
      @conversation.user_receiver = receiver_pos.user
    end

    def finialize_save
      if @conversation.save({ state: :offered })
        publish :succesful, @conversation
      else
        publish :error, @conversation.errors
      end
      @conversation
    end

    def validate_arguments
      %w(caller_position_id receiver_position_id).each do |var|
        unless instance_variables.include? :"@#{var}"
          raise ArgumentError.new("There is no '#{var}' in #{self.class}")
        end
      end
    end

end
