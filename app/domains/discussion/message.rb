class Discussion::Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String

  embedded_in :conversation

end
