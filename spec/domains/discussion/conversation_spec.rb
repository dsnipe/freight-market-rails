require 'rails_helper'

RSpec.describe Discussion::Conversation do
  let(:conversation) { FactoryGirl.create(:conversation) }

  it "should be correct" do
    expect(conversation.caller).to_not eq(conversation.receiver)
  end
  it "should add message" do
    conversation.add_message(conversation.receiver, "it's working")
    expect(conversation.receiver_messages.first.body).to eq("it's working")
  end
end
