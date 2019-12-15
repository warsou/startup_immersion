class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def require_admin
  	unless current_user.admin?
  	  redirect_to root_path
  	end
  end
  
  def self.local_prefixes
  	[controller_path, controller_path.sub(/^admin\//, '')]
  end
end
