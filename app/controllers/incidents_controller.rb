class IncidentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @incidents = current_user.incidents.order(created_at: :desc).page(params[:page]).per(5)
  end

  def new
    @incident = Incident.new
  end

  def create
    @incident = current_user.incidents.build(incident_params)
    puts @incident
    if @incident.save
      redirect_to incidents_path, notice: t('defaults.flash_message.created', item: Incident.model_name.human)
    else
      flash.now[:alert] = t('defaults.flash_message.not_created', item: Incident.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def incident_params
    params.require(:incident).permit(:book, :name, :tag, :body)
  end
end
