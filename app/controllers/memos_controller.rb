class MemosController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_character, only: [:edit, :update, :destroy]

  def create
    @incident = current_user.incidents.find(params[:incident_id])
    @memo = @incident.memos.build(memo_params)
    @memo.save
  end

  private

  def memo_params
    params.require(:memo).permit(:tag, :body)
  end
end
