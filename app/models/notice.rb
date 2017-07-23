# app/models/notice.rb

class Notice < ApplicationRecord
	# validations
  validates_presence_of :notice_for, :details, :important_dates, :attachments_needed
end
