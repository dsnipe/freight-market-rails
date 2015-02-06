class Customer::User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String

  has_many :discussions, class_name: "Discussion::Conversation", as: :conversations
  has_many :positions_vessel, class_name: "Market::PositionVessel"
  has_many :positions_cargo, class_name: "Market::PositionCargo"

end
