# spec/models/notice_spec.rb

require 'rails_helper'

RSpec.describe Notice, type: :model do
  # Validation tests
  # ensure columns notice_for, details, important_dates and attachments_needed are present before saving
  it { should validate_presence_of(:notice_for) }
  it { should validate_presence_of(:details) }
  it { should validate_presence_of(:important_dates) }
  it { should validate_presence_of(:attachments_needed) }
end
