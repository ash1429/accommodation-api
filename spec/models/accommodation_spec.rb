# spec/models/accommodation_spec.rb
require 'rails_helper'

RSpec.describe Accommodation, type: :model do
	 # Validation tests
  # ensure columns typo is present before saving
	it { should validate_presence_of(:typo) }
end
