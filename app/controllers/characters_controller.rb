class CharactersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_character, only: [ :edit, :update, :destroy ]

  def index
    @incident = current_user.incidents.find(params[:incident_id])
    @characters = @incident.characters.order(created_at: :asc)
    @character = Character.new
  end

  def create
    @incident = current_user.incidents.find(params[:incident_id])
    @character = @incident.characters.build(character_params)
    @character.save
  end

  def edit
  end

  def update
    if @character.update(character_params)
      redirect_to incident_characters_path(@incident, anchor: "character-id-#{@character.id}"),
      notice: t("defaults.flash_message.updated", item: Character.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: Character.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @character.destroy!
    flash.now[:notice] = t("defaults.flash_message.deleted", item: Character.model_name.human)
  end

  private

  def character_params
    params.require(:character).permit(:name, :gender, :age, :role, :body)
  end

  def set_character
    @incident = current_user.incidents.find(params[:incident_id])
    @character = @incident.characters.find(params[:id])
  end
end
