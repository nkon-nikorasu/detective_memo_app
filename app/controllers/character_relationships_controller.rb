class CharacterRelationshipsController < ApplicationController
  before_action :set_incident, only: %i[index new create edit update destroy]
  before_action :set_characters, only: %i[index new create edit update destroy]
  before_action :set_character_relationship, only: %i[edit update destroy]

  def index
    @character_relationship = CharacterRelationship.new
    @relationships = relationships_for_incident
    set_selected_character_relationships
  end

  def new
    @character_relationship = CharacterRelationship.new
  end

  def create
    @character_relationship = CharacterRelationship.new(
      character_relationship_params.except(
        :source_character_id,
        :target_character_id
      )
    )

    assign_characters(@character_relationship)

    if @character_relationship.save
      set_relationship_display
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

    assign_characters(@character_relationship)

    if @character_relationship.save
      set_relationship_display
      flash.now[:notice] = t(
        "defaults.flash_message.updated",
        item: CharacterRelationship.model_name.human
      )
    end
  end

  def destroy
    @character_relationship.destroy!
    @relationships = relationships_for_incident
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
    character_ids = @incident.characters.select(:id)
    CharacterRelationship.where(
      source_character_id: character_ids,
      target_character_id: character_ids
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

  def set_selected_character_relationships
    if params[:character_id].present?
      @character = @incident.characters.find(params[:character_id])
      @character_relationships = relationships_for_character(@character)
    else
      @character_relationships = CharacterRelationship.none
    end
  end

  def set_relationship_display
    @relationships = relationships_for_incident
    @character = @character_relationship.source_character
    @character_relationships = relationships_for_character(@character)
  end

  def relationships_for_character(character)
    relationships_for_incident.where(
      "source_character_id = :id OR target_character_id = :id",
      id: character.id
    )
    .includes(:source_character, :target_character)
    .order(:created_at, :id)
  end

  def assign_characters(relationship)
    relationship.source_character = @incident.characters.find_by(
      id: character_relationship_params[:source_character_id]
    )

    relationship.target_character = @incident.characters.find_by(
      id: character_relationship_params[:target_character_id]
    )
  end
end
