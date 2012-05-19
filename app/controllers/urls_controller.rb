class UrlsController < ApplicationController

  def index
    @urls = Url.all
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(params[:url])
    if @url.save
      redirect_to :root, notice: 'Url was successfully created.'
    else
      render action: "new"
    end
  end

end
