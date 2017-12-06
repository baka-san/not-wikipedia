class Collaboration < ApplicationRecord
  # belongs_to :user
  # belongs_to :wiki

  belongs_to :collaborator, class_name: "User"
  belongs_to :wiki
end
