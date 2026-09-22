class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  layout :set_layout

  private

  def set_layout
    if self.class.name.start_with?('Admin::')
      'admin'
    else
      'application'
    end
  end
end
