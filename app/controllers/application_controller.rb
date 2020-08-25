class ApplicationController < ActionController::Base
  ## Will protect from the forgery
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

  protected

  def resource_not_found

  end

end
