class IncidentTimesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_incident_time, only: [ :edit, :update, :destroy, :move_higher, :move_lower ]

  def index
    @incident = current_user.incidents.find(params[:incident_id])
    @incident_times = @incident.incident_times.order(:position)
    @incident_time = IncidentTime.new
  end

  def create
    @incident = current_user.incidents.find(params[:incident_id])
    @incident_time = @incident.incident_times.build(incident_time_params)
    if @incident_time.save
      flash.now[:notice] = t("defaults.flash_message.created", item: IncidentTime.model_name.human)
    end
  end

  def new
    @incident = current_user.incidents.find(params[:incident_id])
    @incident_time = @incident.incident_times.build
  end

  def edit
  end

  def update
    if @incident_time.update(incident_time_params)
      flash.now[:notice] = t("defaults.flash_message.updated", item: IncidentTime.model_name.human)
    end
  end

  def destroy
    @incident_time.destroy!
    flash.now[:notice] = t("defaults.flash_message.deleted", item: IncidentTime.model_name.human)
  end

  def move_higher
    @incident_time.move_higher
    redirect_to incident_incident_times_path(@incident, anchor: "table-time-record")
  end

  def move_lower
    @incident_time.move_lower
    redirect_to incident_incident_times_path(@incident, anchor: "table-time-record")
  end

  private

  def incident_time_params
    params.require(:incident_time).permit(:year, :month, :date, :hour, :minute, :second, :body)
  end

  def set_incident_time
    @incident = current_user.incidents.find(params[:incident_id])
    @incident_time = @incident.incident_times.find(params[:id])
  end
end
