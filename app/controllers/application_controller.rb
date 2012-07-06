class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :redirect_if_www

  private

  def redirect_if_www
    request_uri = request.env['REQUEST_URI']
    redirect_to request_uri.gsub('http://www.', 'http://') unless /http:\/\/www\./.match(request_uri).nil?
  end
end
