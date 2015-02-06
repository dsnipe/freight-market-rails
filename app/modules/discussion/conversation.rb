class Discussion::Conversation
  include Mongoid::Document
  include Mongoid::Timestamps
  include Wisper::Publisher
  extend Enumerize

  field :caller_init_state, type: Hash
  field :receiver_init_state, type: Hash
  field :state
  enumerize :state, in: %w(offered open closed fixed)

  embeds_many :messages

  belongs_to :user_caller, class_name: "Customer::User", polymorphic: true
  belongs_to :user_receiver, class_name: "Customer::User", polymorphic: true

  belongs_to :position_cargo, class_name: "Market::PositionCargo"
  belongs_to :position_vessel, class_name: "Market::PositionVessel"

  def add_message(body, sender)
    messages << Discussion::Message.new({body: body, owner: sender})
    publish :message_sent, {status: 'ok'}
  end

  def receiver_messages
    messages.where('owner' => user_receiver.id)
  end

  def caller_messages
    messages.where('owner' => user_caller.id)
  end

end
