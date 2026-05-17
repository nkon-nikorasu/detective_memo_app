class IncidentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_incident, only: [:edit, :update, :destroy]
  def index
    @incidents = current_user.incidents.order(created_at: :desc).page(params[:page]).per(5)
  end

  def new
    @incident = Incident.new
  end

  def create
    @incident = current_user.incidents.build(incident_params)
    if @incident.save
      redirect_to edit_incident_path(@incident), notice: t('defaults.flash_message.created', item: Incident.model_name.human)
    else
      flash.now[:alert] = t('defaults.flash_message.not_created', item: Incident.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @incident.update(incident_params)
      redirect_to edit_incident_path(@incident), notice: t('defaults.flash_message.updated', item: Incident.model_name.human)
    else
      flash.now[:alert] = t('defaults.flash_message.not_updated', item: Incident.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @incident.destroy!
    redirect_to incidents_path, notice: t('defaults.flash_message.deleted', item: Incident.model_name.human), status: :see_other
  end

  private

  def incident_params
    params.require(:incident).permit(:book, :name, :tag, :body)
  end

  def set_incident
    @incident = current_user.incidents.find(params[:id])
  end
end
