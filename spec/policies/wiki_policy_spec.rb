require 'rails_helper'

# Public    index | show | new | create | edit | update | destroy | Private (all)
# Guest        x      x
# Standard     x      x     x       x      x      x        x
# Premium      x      x     x       x      x      x        x           x
# Admin = Premium
RSpec.describe WikiPolicy do

  subject { WikiPolicy.new(user, article) }

  let(:user) { create(:user) }
  let(:premium_user) { create(:user) }
  let(:wiki) { create(:wiki, user_id: user.id) }
  let(:private_wiki) { create(:wiki, user_id: premium_user.id), private: true }

  # context "guest user" do

  #   before do  
  #     current_user = nil
  #   end

  #   it { should     permit(:show)    }
  #   it { should_not permit(:create)  }
  #   it { should_not permit(:new)     }
  #   it { should_not permit(:update)  }
  #   it { should_not permit(:edit)    }
  #   it { should_not permit(:destroy) }
  # end

  # context "standard user - own wiki" do

  #   before do     
  #     sign_in user
  #   end

  #   it { should permit(:show)    }
  #   it { should permit(:create)  }
  #   it { should permit(:new)     }
  #   it { should permit(:update)  }
  #   it { should permit(:edit)    }
  #   it { should permit(:destroy) }
  # end

  # context "standard user - other user's wiki" do

  #   before do  
  #     let(:user) { create(:user) }
  #     let(:other_user) { create(:user) }
  #     let(:wiki) { create(:wiki, user_id: other_user.id) }
      
  #     sign_in user
  #   end

  #   it { should permit(:show)    }
  #   it { should permit(:create)  }
  #   it { should permit(:new)     }
  #   it { should permit(:update)  }
  #   it { should permit(:edit)    }
  #   it { should permit(:destroy) }
  # end


  # permissions ".scope" do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :show? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :create? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :update? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :destroy? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end
end
