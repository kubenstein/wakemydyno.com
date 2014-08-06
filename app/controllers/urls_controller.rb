class UrlsController < ApplicationController

  def new
    @url = Url.new(params[:url])
  end

  def create
    @url = Url.new(params[:url])
    if @url.save
      redirect_to :root, notice: 'Url was successfully added to our dyno database!'
    else
      render :new
    end
  end

end
