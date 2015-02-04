class Discussion::Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :owner, type: Moped::BSON::ObjectId

  embedded_in :conversation

end
