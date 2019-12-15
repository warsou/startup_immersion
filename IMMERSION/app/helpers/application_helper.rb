module ApplicationHelper
  def devise_flash
  if controller.devise_controller? && resource.errors.any?
    flash.now[:error] = flash[:error].to_a.concat resource.errors.full_messages
    flash.now[:error].uniq!
  end
end
end
