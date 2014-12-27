module	AbstractPosition
	extend ActiveSupport::Concern

	included do
		include Mongoid::Document
		include Mongoid::Timestamps
		extend Enumerize

		field :open_date, type: Date
		field :close_date, type: Date
		field :state, type: String

		enumerize :state, in: [:active, :closed], default: :active, predicates: true
	end

end