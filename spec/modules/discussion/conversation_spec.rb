require 'rails_helper'

RSpec.describe Discussion::Conversation do
  let(:conversation) { FactoryGirl.create(:conversation) }

  it "should be correct" do
    expect(conversation.user_caller).to_not eq(conversation.user_receiver)
  end
  it "should add message" do
    conversation.add_message("it's working", conversation.user_receiver.id)
    expect(conversation.receiver_messages.first.body).to eq("it's working")
  end
end
