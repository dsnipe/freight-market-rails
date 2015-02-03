class Discussion::Conversation
  include Mongoid::Document
  include Mongoid::Timestamps
  extend Enumerize

  field :caller_init_state, type: Hash
  field :receiver_init_state, type: Hash
  field :state
  enumerize :state, in: %w(offered open closed fixed)

  embeds_many :messages

  belongs_to :caller, class_name: "Customer::User", polymorphic: true
  belongs_to :receiver, class_name: "Customer::User", polymorphic: true

  belongs_to :position_cargo, class_name: "Market::PositionCargo"
  belongs_to :position_vessel, class_name: "Market::PositionVessel"

end
