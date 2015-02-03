require 'rails_helper'

RSpec.describe Discussion::ConversationFactory do

  let(:caller) { FactoryGirl.create(:user) }
  let(:receiver) { FactoryGirl.create(:user) }

  let(:pc) { FactoryGirl.create('position_cargo') }
  let(:pv) { FactoryGirl.create('position_vessel') }

  let(:correct_data) do
    {
      caller: caller,
      receiver: receiver,
      receiver_position: pc,
      caller_position: pv
    }
  end

  it "should create conversation" do
    conv_fact = Discussion::ConversationFactory.new(correct_data)
    conv_fact.message = 'Ho ho ho'
    expect(conv_fact.save).to_not be_nil
  end
  it "shouldn't create conversation" do
    incorrect_data = correct_data.reject { |k,v| k == :caller }
    conv_fact = Discussion::ConversationFactory.new(incorrect_data)
    conv_fact.message = 'Ho ho ho'
    expect { conv_fact.save }.to raise_error(ArgumentError)
  end

  describe "when have saved conversation" do
    let(:conv_fact) {
      Discussion::ConversationFactory.new(correct_data.merge({message: 'Hey'})).save()
      }

    it "should store correct serialized positions" do
      expect(conv_fact.caller_init_state).to eq(JSON.parse(pv.to_json))
    end
    it "should have message" do
      expect(conv_fact.messages.size).to eq(1)
      expect(conv_fact.messages[0].body).to eq('Hey')
    end

    it "should have caller and receiver" do
      expect(conv_fact.caller).to eq(caller)
      expect(conv_fact.receiver).to eq(receiver)
    end
  end
end
