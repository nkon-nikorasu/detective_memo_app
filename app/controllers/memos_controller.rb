class MemosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_memo, only: [:edit, :update]

  def create
    @incident = current_user.incidents.find(params[:incident_id])
    @memo = @incident.memos.build(memo_params)
    @memo.save
  end

  def edit
  end

  def update
    if @memo.update(memo_params)
      redirect_to incident_path(@incident, anchor: "memo-record-#{ @memo.id }" ),
      notice: t('defaults.flash_message.updated', item: Memo.model_name.human)
    else
      flash.now[:alert] = t('defaults.flash_message.not_updated', item: Memo.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:tag, :body)
  end

  def set_memo
    @incident = current_user.incidents.find(params[:incident_id])
    @memo = @incident.memos.find(params[:id])
  end
end
