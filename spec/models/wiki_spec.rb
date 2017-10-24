require 'rails_helper'
include RandomData


RSpec.describe Wiki, type: :model do
  
  let(:user) { create(:user) }
  let(:wiki) { create(:wiki, user_id: user.id) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:user) }
  
  it { is_expected.to validate_length_of(:title).is_at_least(1) }  
  it { is_expected.to validate_length_of(:title).is_at_least(1) }  

  describe "attributes" do
    it "has a title, body, private, and user attribute" do
      expect(wiki).to have_attributes(title: wiki.title, body: wiki.body, user: wiki.user)
    end
  end
end
