class AimsController < ApplicationController
  def index
    @aims = Aim.all
  end

  def show
    @aim = Aim.find(params[:id])
  end
end
