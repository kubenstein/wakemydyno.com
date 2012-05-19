class PingsController < ApplicationController

  def index
    @pings = Ping.all
  end

  def new
    @ping = Ping.new
  end

  def create
    @ping = Ping.new(params[:ping])
    if @ping.save
      redirect_to :root, notice: 'Ping was successfully created.'
    else
      render action: "new"
    end
  end

end
