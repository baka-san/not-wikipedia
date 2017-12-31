require 'rails_helper'

RSpec.describe CollaborationPolicy do

  let(:user) { create(:user) }
  let(:premium_user) { create(:user, role: 'premium') }
  let(:admin) {create(:user, role: 'admin')}
  let(:collaborator) {create(:user, role: 'standard')}

  let(:public_wiki) { create(:wiki, user_id: user.id) }
  let(:private_wiki) { create(:wiki, user_id: premium_user.id, private: true) }
  let(:private_wiki_admin) { create(:wiki, user_id: admin.id, private: true) }

  subject { CollaborationPolicy }

  permissions :create?, :destroy? do

    before do
      collaborator.collaborations.create(wiki_id: private_wiki.id)
    end

    it "allows :create?, :destroy? to admins, owners, and collaborators of a private wiki" do
      expect(subject).to permit(premium_user, Collaboration.create(wiki_id: private_wiki, user_id: user.id))
      expect(subject).to permit(admin, Collaboration.create(wiki_id: private_wiki, user_id: user.id))
      expect(subject).to permit(collaborator, Collaboration.create(wiki_id: private_wiki, user_id: user.id))
    end

    it "denies :create?, :destroy? to anyone who isn't collaborating on a private wiki" do
      expect(subject).not_to permit(collaborator, Collaboration.create(wiki_id: private_wiki_admin, user_id: user.id))
    end

  end
end
