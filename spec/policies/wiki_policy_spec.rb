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
  let(:collaborator) {create(:user, role: 'standard')}

  let(:public_wiki) { create(:wiki, user_id: user.id) }
  let(:private_wiki) { create(:wiki, user_id: premium_user.id, private: true) }
  let(:private_wiki_admin) { create(:wiki, user_id: admin.id, private: true) }

  subject { WikiPolicy }

  permissions :show?, :new?, :create?, :edit?, :update?, :destroy? do

    before do
      collaborator.collaborations.create(wiki_id: private_wiki.id)
    end

    it "allows :show?, :new?, :create?, :edit?, :update?, :destroy? 
    to all users for any public wiki" do
      expect(subject).to permit(user, public_wiki)
      expect(subject).to permit(premium_user, public_wiki)
      expect(subject).to permit(admin, public_wiki)
    end

    it "allows :show?, :new?, :create?, :edit?, :update?, :destroy? 
    to admins, owners, and collaborators of a private wiki" do
      expect(subject).to permit(premium_user, private_wiki)
      expect(subject).to permit(admin, private_wiki)
      expect(subject).to permit(collaborator, private_wiki)
    end

    it "denies :show?, :new?, :create?, :edit?, :update?, :destroy? 
    to standard users, non-owners, and anyone who isn't collaborating on a private wiki" do
      expect(subject).not_to permit(collaborator, private_wiki_admin)
      expect(subject).not_to permit(user, private_wiki)
    end

  end

end
