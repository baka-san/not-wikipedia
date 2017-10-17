require 'rails_helper'

RSpec.describe User, type: :model do
  # # Shoulda tests for email
  # it { is_expected.to validate_presence_of(:email) }
  # it { is_expected.to validate_uniqueness_of(:email) }
  # it { is_expected.to allow_value("user@bloccit.com").for(:email) }

  # # Shoulda tests for password
  # it { is_expected.to validate_presence_of(:password) }
  # it { is_expected.to have_secure_password }
  # it { is_expected.to validate_length_of(:password).is_at_least(6) }

end
