class IncidentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_incident, only: [ :edit, :update, :destroy, :show ]
  def index
    @incidents = current_user.incidents.includes(:book).order(created_at: :desc).page(params[:page]).per(5)
  end

  def new
    @incident = Incident.new
  end

  def create
    @incident = current_user.incidents.build(incident_params)
    if @incident.save
      flash[:notice] = t("defaults.flash_message.created", item: Incident.model_name.human)
    end

    respond_to do |format|
      format.turbo_stream
      format.html do
        if @incident.persisted?
          redirect_to incident_path(@incident), status: :see_other
        else
          render :new, status: :unprocessable_entity
        end
      end
    end
  end

  def edit
  end

  def update
    if @incident.update(incident_params)
      flash.now[:notice] = t("defaults.flash_message.updated", item: Incident.model_name.human)
    end
  end

  def show
  end

  def destroy
    @incident.destroy!
    redirect_to incidents_path, notice: t("defaults.flash_message.deleted", item: Incident.model_name.human), status: :see_other
  end

  private

  def incident_params
    params.require(:incident).permit(:name, :tag, :body)
  end

  def set_incident
    @incident = current_user.incidents.find(params[:id])
  end
end
