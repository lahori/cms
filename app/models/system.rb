class System < ApplicationRecord
	has_many :appliances, dependent: :destroy
end