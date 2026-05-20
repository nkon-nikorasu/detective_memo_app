class IncidentTimesController < ApplicationController
  def create
    puts "ここまで通っている"
    @incident = Incident.find(params[:incident_id])
    @incident_time = @incident.incident_times.build(incident_time_params)
    @incident_time.save
    p "インシデントタイムです>#{@incident_time.class}"
    p "インシデントタイムです>#{@incident_time.inspect}"
    puts "ここまで通ってます"
  end

  private

  def incident_time_params
    params.require(:incident_time).permit(:year, :month, :date, :hour, :minute, :second, :body)
  end
end