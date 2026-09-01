class TasksController < ApplicationController
  before_action :require_login
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks =
      if params[:search].present?
        tasks = current_user.tasks

        if params[:search][:title].present?
          tasks = tasks.search_title(params[:search][:title])
        end

        if params[:search][:status].present?
          tasks = tasks.search_status(params[:search][:status])
        end

        tasks.recent
      elsif params[:sort_deadline_on]
        current_user.tasks.sort_deadline_on
      elsif params[:sort_priority]
        current_user.tasks.sort_priority
      else
        current_user.tasks.recent
      end

    @tasks = @tasks.page(params[:page]).per(10)
  end

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: I18n.t('tasks.flash.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: I18n.t('tasks.flash.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: I18n.t('tasks.flash.destroyed')
  end

  private

  def set_task
    @task = current_user.tasks.find_by(id: params[:id])

    return if @task

    redirect_to tasks_path, alert: 'アクセス権限がありません'
  end

  def task_params
    params.require(:task).permit(
      :title,
      :content,
      :deadline_on,
      :priority,
      :status
    )
  end
end
