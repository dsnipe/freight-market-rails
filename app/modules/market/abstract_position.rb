module	Market::AbstractPosition
	extend ActiveSupport::Concern

	class InterfaceNotImplementedError < NoMethodError; end

	included do
		include Mongoid::Document
		include Mongoid::Timestamps
		extend Enumerize

		field :open_date, type: Date
		field :close_date, type: Date
		field :state, type: String

		enumerize :state, in: [:active, :closed], default: :active, predicates: true

		has_many :conversation, class_name: "Discussion::Conversation"
	end

	def position_type
		raise InterfaceNotImplementedError.new
	end

end
