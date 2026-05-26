class CharactersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_character, only: [:edit, :update]
  def create
    @incident = current_user.incidents.find(params[:incident_id])
    @character = @incident.characters.build(character_params)
    @character.save
  end

  def edit
  end

  def update
    if @character.update(character_params)
      redirect_to edit_incident_path(@incident, anchor: "character-id-#{@character.id}" ),
      notice: t('defaults.flash_message.updated', item: Character.model_name.human)
    else
      flash.now[:alert] = t('defaults.flash_message.not_updated', item: Character.model_name.human)
      render :edit, status: :unprocessable_entity
    end
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
