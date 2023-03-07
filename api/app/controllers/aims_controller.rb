class AimsController < ApplicationController
  before_action :set_aim, only: [:show, :edit, :update, :destroy]

  def index
    @q = Aim.ransack(params[:q])
    @aims = @q.result.page(params[:page]).per(5)
  end

  def show
  end
  

  def new
    @aim = Aim.new
  end

  def create
    @aim = Aim.new(aim_params)
    if @aim.save
      flash[:success] = '目標を作成しました'
      redirect_to aims_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @aim.update(aim_params)
      flash[:success] = "目標を更新しました"
      redirect_to aim_path(@aim.id)
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @aim.destroy
    flash[:success] = '目標を削除しました'
    redirect_to aims_path
  end

  private

    def set_aim
      @aim = Aim.find(params[:id])
    end

   def aim_params
    params.require(:aim).permit(:title, :reason, :advantage, :difficulty)
   end
end
