class IncidentTimesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_incident_time, only: [:edit, :update, :destroy, :move_higher, :move_lower]
  def create
    puts "ここまで通っている"
    @incident = current_user.incidents.find(params[:incident_id])
    @incident_time = @incident.incident_times.build(incident_time_params)
    @incident_time.save
    p "インシデントタイムです>#{@incident_time.class}"
    p "インシデントタイムです>#{@incident_time.inspect}"
    puts "ここまで通ってます"
  end

  def edit
  end

  def update
    if @incident_time.update(incident_time_params)
      redirect_to edit_incident_path(@incident, anchor: "time-record-#{@incident_time.id}" ),
      notice: t('defaults.flash_message.updated', item: IncidentTime.model_name.human)
    else
      flash.now[:alert] = t('defaults.flash_message.not_updated', item: IncidentTime.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @incident_time.destroy!
  end

  def move_higher
    @incident_time.move_higher
    redirect_to edit_incident_path(@incident, anchor: "time-record-#{@incident_time.id}" )
  end

  def move_lower
    @incident_time.move_lower
    redirect_to edit_incident_path(@incident, anchor: "time-record-#{@incident_time.id}" )
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