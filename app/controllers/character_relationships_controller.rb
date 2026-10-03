class CharacterRelationshipsController < ApplicationController
  before_action :set_incident
  before_action :set_characters, only: %i[index create edit update]
  before_action :set_character_relationship, only: %i[edit update destroy]

  def index
    @character_relationship = CharacterRelationship.new
    if params[:character_id].present?
      @character = @incident.characters.find(params[:character_id])
      @character_relationships = @character.relationships
    else
      @character_relationships = CharacterRelationship.none
    end
  end

  def create
    @character_relationship = CharacterRelationship.new(
      character_relationship_params.except(
        :source_character_id,
        :target_character_id
      )
    )

    @character_relationship.source_character =
      @incident.characters.find_by(
        id: character_relationship_params[:source_character_id]
      )

    @character_relationship.target_character =
      @incident.characters.find_by(
        id: character_relationship_params[:target_character_id]
      )

    if @character_relationship.save
      flash.now[:notice] = t(
        "defaults.flash_message.created",
        item: CharacterRelationship.model_name.human
      )
    end
  end

  # edit/update/destroy...
  def edit
  end

  def update
    @character_relationship.assign_attributes(
      character_relationship_params.except(
        :source_character_id,
        :target_character_id
      )
    )

    @character_relationship.source_character =
      @incident.characters.find_by(
        id: character_relationship_params[:source_character_id]
      )

    @character_relationship.target_character =
      @incident.characters.find_by(
        id: character_relationship_params[:target_character_id]
      )

    if @character_relationship.save
      redirect_to incident_character_relationships_path(@incident, character_id: params[:character_id]),
      notice: t("defaults.flash_message.updated", item: CharacterRelationship.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: CharacterRelationship.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @character_relationship.destroy!
    flash.now[:notice] = t("defaults.flash_message.deleted", item: CharacterRelationship.model_name.human)
  end

  private

  def set_incident
    @incident = current_user.incidents.find(params[:incident_id])
  end

  def set_characters
    @characters = @incident.characters
  end

  def set_character_relationship
    @character_relationship = relationships_for_incident.find(params[:id])
  end

  def relationships_for_incident
    CharacterRelationship.where(
      source_character_id: @incident.characters.ids,
      target_character_id: @incident.characters.ids
    )
  end

  def character_relationship_params
    params.require(:character_relationship).permit(
      :source_character_id,
      :target_character_id,
      :relation,
      :source_to_target_impression,
      :target_to_source_impression
    )
  end
end
