require 'rails_helper'

# Public    index | show | new | create | edit | update | destroy | Private (all)
# Guest        x      x
# Standard     x      x     x       x      x      x        x
# Premium      x      x     x       x      x      x        x           x
# Admin = Premium

RSpec.describe WikiPolicy do

  let(:user) { create(:user) }
  let(:premium_user) { create(:user, role: 'premium') }
  let(:admin) {create(:user, role: 'admin')}
  let(:wiki) { create(:wiki, user_id: user.id) }
  let(:private_wiki) { create(:wiki, user_id: premium_user.id, private: true) }
  let(:private_wiki_admin) { create(:wiki, user_id: admin.id, private: true) }

  subject { WikiPolicy }

  permissions :show?, :new?, :create?, :edit?, :update?, :destroy? do

    it "allows :show?, :new?, :create?, :edit?, :update?, :destroy? to all users for any public wiki" do
      expect(subject).to permit(user, wiki)
      expect(subject).to permit(premium_user, wiki)
      expect(subject).to permit(admin, wiki)
    end

    it "allows :show?, :new?, :create?, :edit?, :update?, :destroy? to admins and owners of a private wiki" do
      expect(subject).to permit(premium_user, private_wiki)
      expect(subject).to permit(admin, private_wiki)
    end

    it "denies :show?, :new?, :create?, :edit?, :update?, :destroy? to standard users and non-owners if private wiki" do
      expect(subject).not_to permit(premium_user, private_wiki_admin)
      expect(subject).not_to permit(user, private_wiki)
    end
  end

end
