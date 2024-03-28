class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @tasks  = @user.tasks.order('limit_date').all
    @status = ['未達成', '進行中', '達成済']
  end

  def update
    current_user.update(update_params)
  end

  def user_params
    params.require(:user).permit(:name, :email, :image)
  end

  # private
  def update_params
    params.require(:user).permit(:image)
  end
end
