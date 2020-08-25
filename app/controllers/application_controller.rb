class ApplicationController < ActionController::Base
  ## Will protect from the forgery
  protect_from_forgery with: :exception
end
