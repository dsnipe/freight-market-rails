require "rails_helper"

RSpec.describe "Discussion API" do
  include_context "API Helpers"

  let(:conv) {FactoryGirl.create(:conversation)}

  it "should send offer to opponent" do
    p1 = FactoryGirl.create(:position_vessel)
    p2 = FactoryGirl.create(:position_cargo)
    data = {
      caller_position_id: p1.id,
      caller_position_type: p1.position_type,
      receiver_position_id: p2.id,
      message: 'Hey! Wasup?'
    }
    post '/api/discussions/conversations/offer', data
    conversation = ::Discussion::Conversation.last
    expect_json(prepare_record(conversation))
  end

  it "should get list of messages for specific conversation" do
    conv.add_message('Hey, so?', conv.user_caller.id)
    conv.add_message('No, thnx', conv.user_receiver.id)
    get "/api/discussions/conversations/#{conv.id.to_s}"
    expect_json({messages: prepare_record(conv.messages), conversation_id: conv.id.to_s})
  end

  it "should send message to conversation" do
    data = {
      conversation_id: conv.id,
      body: "It's cool",
      owner_id: conv.user_receiver.id
    }
    post '/api/discussions/conversations/message', data
    expect_json({status: "ok"})
  end

end
