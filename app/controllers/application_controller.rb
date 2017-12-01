class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  include ApplicationHelper
  include WikisHelper
  include MarkdownHelper

  # before_action :set_last_seen_at, 
  #   if: proc { user_signed_in? && (User[:last_sign_in_at] == nil || User[:last_sign_in_at] < 15.minutes.ago) }

  # private

  #   def set_last_sign_in_at
  #     current_user.update_attribute(:last_sign_in_at, Time.current)
  #     User[:last_sign_in_at] = Time.current
  #   end

end

