class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :redirect_if_www

  private

  def redirect_if_www
    request_uri = request.env['HTTP_HOST']
    redirect_to request_uri.gsub('www.', 'http://') if request_uri.include?('www.')
  end
end