FactoryGirl.define do

  factory :conversation, class: Discussion::Conversation do
    caller_init_state Hash.new
    receiver_init_state Hash.new
    state 'open'
    position_cargo
    position_vessel
  end

end
