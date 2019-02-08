class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # SessionsHelperをView内だけでなく、Controller内でも使えるようにするためMix-inしている
  # Mix-inとはModule内のインスタンスメソッドを当該Controller内でも使えるようにすること
  include SessionsHelper

  private

  def require_user_logged_in
     unless logged_in?
      redirect_to login_url
     end
  end
end
