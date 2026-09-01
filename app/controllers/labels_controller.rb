class LabelsController < ApplicationController
  before_action :require_login

  def index
    @labels = current_user.labels
  end

  def new
    @label = current_user.labels.new
  end

  def create
    @label = current_user.labels.new(label_params)

    if @label.save
      redirect_to labels_path, notice: 'ラベルを登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @label = current_user.labels.find(params[:id])
  end

  def update
    @label = current_user.labels.find(params[:id])

    if @label.update(label_params)
      redirect_to labels_path, notice: 'ラベルを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @label = current_user.labels.find(params[:id])
    @label.destroy
    redirect_to labels_path, notice: 'ラベルを削除しました'
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end
end