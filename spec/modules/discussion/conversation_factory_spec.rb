require 'rails_helper'

RSpec.describe Discussion::ConversationFactory do

  let(:pc) { FactoryGirl.create('position_cargo') }
  let(:pv) { FactoryGirl.create('position_vessel') }

  let(:correct_data) do
    {
      caller_position_id: pv.id,
      caller_position_type: pv.position_type,
      receiver_position_id: pc.id
    }
  end

  it "should create conversation" do
    conv_fact = Discussion::ConversationFactory.new(correct_data)
    conv_fact.message = 'Ho ho ho'
    expect(conv_fact.save).to_not be_nil
  end
  it "shouldn't create conversation" do
    incorrect_data = correct_data.reject { |k,v| k == :caller_position_id }
    conv_fact = Discussion::ConversationFactory.new(incorrect_data)
    conv_fact.message = 'Ho ho ho'
    expect { conv_fact.save }.to raise_error(ArgumentError)
  end

  describe "when have saved conversation" do
    let(:conv_fact) {
      Discussion::ConversationFactory.new(correct_data.merge({message: 'Hey'})).save()
      }

    before(:each) do
      @user_caller = pv.user
      @user_receiver = pc.user
    end

    it "should store correct serialized positions" do
      expect(conv_fact.caller_init_state).to eq(JSON.parse(pv.to_json))
    end
    it "should have message" do
      expect(conv_fact.messages.size).to eq(1)
      expect(conv_fact.messages[0].body).to eq('Hey')
    end

    it "should have caller and receiver" do
      expect(conv_fact.user_caller).to eq(@user_caller)
      expect(conv_fact.user_receiver).to eq(@user_receiver)
    end

    it "message should have owner same as caller" do
      expect(conv_fact.messages[0].owner).to eq(@user_caller.id)
    end
  end
end
