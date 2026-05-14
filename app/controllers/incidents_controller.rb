class IncidentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @incidents = current_user.incidents.order(created_at: :desc).page(params[:page]).per(5)
  end
end
