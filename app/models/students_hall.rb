class StudentsHall < ApplicationRecord
	# validations
  validates_presence_of :names, :contact_no
end
