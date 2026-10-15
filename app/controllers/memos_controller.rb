class MemosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_memo, only: [ :edit, :update, :destroy ]

  def index
    @incident = current_user.incidents.find(params[:incident_id])
    @memos = @incident.memos
    @memo = Memo.new
  end

  def new
    @incident = current_user.incidents.find(params[:incident_id])
    @memo = @incident.memos.build
  end

  def create
    @incident = current_user.incidents.find(params[:incident_id])
    @memo = @incident.memos.build(memo_params)
    if @memo.save
      flash.now[:notice] = t("defaults.flash_message.created", item: Memo.model_name.human)
    end
  end

  def edit
  end

  def update
    if @memo.update(memo_params)
      flash.now[:notice] = t("defaults.flash_message.updated", item: Memo.model_name.human)
    end
  end

  def destroy
    @memo.destroy!
    flash.now[:notice] = t("defaults.flash_message.deleted", item: Memo.model_name.human)
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
