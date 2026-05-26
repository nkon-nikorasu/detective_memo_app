class CharactersController < ApplicationController
  before_action :authenticate_user!
  def create
    @incident = current_user.incidents.find(params[:incident_id])
    @character = @incident.characters.build(character_params)
    @character.save
  end

  private

  def character_params
    params.require(:character).permit(:name, :gender, :age, :role, :body)
  end
end
