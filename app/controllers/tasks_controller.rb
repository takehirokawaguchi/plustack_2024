class TasksController < ApplicationController

  # before_action :authenticate_user!

  def index
    @tasks  = Task.order('limit_date').all
    @status = ['未達成', '進行中', '達成済']
  end

  def create
    task = Task.new
    task.user_id = current_user.id
    task.task       = params[:task]
    task.state      = params[:state]
    task.limit_date = params[:limit_date]
    task.save do
    redirect_to '/tasks', notice: '目標を作成しました。'
    end
  end

  def show
    @task   = Task.find(params[:id])
    @status = ['未達成', '進行中', '達成済']
  end

  def update
    task = Task.find(params[:id])
    task.task       = params[:task]
    task.state      = params[:state]
    task.limit_date = params[:limit_date]
    task.save

    redirect_to '/tasks', notice: '目標を更新しました。'
  end

  def destroy
    task       = Task.find(params[:id])
    task.destroy
    redirect_to '/tasks', alert: '目標を削除しました。'
  end
end