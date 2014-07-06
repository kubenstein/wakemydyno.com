class UrlsController < ApplicationController
  before_filter :create_resource

  def create
    @url = Url.new(params[:url])
    if @url.save
      redirect_to :root, notice: 'Url was successfully added to our dyno database!'
    else
      render :new
    end
  end


  private

  def create_resource
    @url = Url.new(params[:url])
  end

end
