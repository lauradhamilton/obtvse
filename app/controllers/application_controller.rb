class ApplicationController < ActionController::Base
  before_filter :ensure_domain

  APP_DOMAIN = 'www.lauradhamilton.com'

  def ensure_domain
    if request.env['HTTP_HOST'] != APP_DOMAIN and ENV['RAILS_ENV'] == 'production'
      # HTTP 301 is a "permanent" redirect
      redirect_to "http://#{APP_DOMAIN}", :status => 301
    end
  end

  protect_from_forgery

  private

  def authenticate
    authenticate_or_request_with_http_basic do |login, password|
      if login == CONFIG['login'] and password == CONFIG['password']
      	session[:admin] = true
      	true
      end
    end
  end
end
