require 'rails_helper'

RSpec.describe "CharacterRelationships", type: :request do
  let(:user) { create(:user) }
  let(:incident) { create(:incident, user: user) }
  let(:source_character) { create(:character, incident: incident) }
  let(:target_character) { create(:character, incident: incident) }

  let(:valid_attributes) do
    {
      source_character_id: source_character.id,
      target_character_id: target_character.id,
      relation: "友人",
      source_to_target_impression: "信頼している",
      target_to_source_impression: "頼りになる"
    }
  end

  before do
    sign_in user
  end

  describe "GET /index" do
    it "人物関係一覧を表示できる" do
      get incident_character_relationships_path(incident)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    context "入力内容が正しい場合" do
      it "人物関係を登録できる" do
        expect {
          post incident_character_relationships_path(incident),
               params: { character_relationship: valid_attributes },
               as: :turbo_stream
        }.to change(CharacterRelationship, :count).by(1)

        expect(response).to have_http_status(:ok)

        relationship = CharacterRelationship.last

        expect(relationship.relation).to eq("友人")
        expect(relationship.source_character).to eq(source_character)
        expect(relationship.target_character).to eq(target_character)
      end

      it "人物関係一覧と相関図を更新するTurbo Streamを返す" do
        post incident_character_relationships_path(incident),
             params: { character_relationship: valid_attributes },
             as: :turbo_stream

        expect(response.body).to include('target="characters-relationship-table"')
        expect(response.body).to include('target="character-relationship-mermaid"')
      end
    end

    context "入力内容が不正な場合" do
      it "人物関係を登録せずフォームを再表示する" do
        invalid_attributes = valid_attributes.merge(relation: "")

        expect {
          post incident_character_relationships_path(incident),
               params: { character_relationship: invalid_attributes },
               as: :turbo_stream
        }.not_to change(CharacterRelationship, :count)

        expect(response.body).to include('target="character-relationship-form"')
      end
    end
  end

  describe "PATCH /update" do
    let!(:relationship) do
      create(
        :character_relationship,
        source_character: source_character,
        target_character: target_character
      )
    end

    context "入力内容が正しい場合" do
      it "人物関係を更新できる" do
        patch incident_character_relationship_path(incident, relationship),
              params: {
                character_relationship: valid_attributes.merge(
                  relation: "兄弟",
                  source_to_target_impression: "仲が良い"
                )
              },
              as: :turbo_stream

        expect(response).to have_http_status(:ok)

        relationship.reload

        expect(relationship.relation).to eq("兄弟")
        expect(relationship.source_to_target_impression).to eq("仲が良い")
      end

      it "人物関係一覧と相関図を更新するTurbo Streamを返す" do
        patch incident_character_relationship_path(incident, relationship),
              params: { character_relationship: valid_attributes },
              as: :turbo_stream

        expect(response.body).to include('target="characters-relationship-table"')
        expect(response.body).to include('target="character-relationship-mermaid"')
      end
    end

    context "入力内容が不正な場合" do
      it "更新せずフォームを再表示する" do
        patch incident_character_relationship_path(incident, relationship),
              params: {
                character_relationship: valid_attributes.merge(relation: "")
              },
              as: :turbo_stream

        expect(relationship.reload.relation).to eq("友人")
        expect(response.body).to include('target="character-relationship-form"')
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:relationship) do
      create(
        :character_relationship,
        source_character: source_character,
        target_character: target_character
      )
    end

    it "人物関係を削除できる" do
      expect {
        delete incident_character_relationship_path(incident, relationship),
               as: :turbo_stream
      }.to change(CharacterRelationship, :count).by(-1)

      expect(response).to have_http_status(:ok)
    end

    it "削除後に一覧と相関図を更新するTurbo Streamを返す" do
      delete incident_character_relationship_path(incident, relationship),
             as: :turbo_stream

      expect(response.body).to include('target="characters-relationship-table"')
      expect(response.body).to include('target="character-relationship-mermaid"')
    end

    it "最後の人物関係を削除すると未登録メッセージが表示される" do
      delete incident_character_relationship_path(incident, relationship),
            params: { character_id: source_character.id },
            as: :turbo_stream

      expect(response).to have_http_status(:ok)

      expect(response.body).to include(
        'target="characters-relationship-table"'
      )

      expect(response.body).to include(
        "人物関係が登録されていません。"
      )
    end
  end

  describe "他ユーザーの事件へのアクセス制御" do
    let(:other_user) { create(:user) }
    let(:other_incident) { create(:incident, user: other_user) }

    it "他ユーザーの事件の人物関係一覧を表示できない" do
      get incident_character_relationships_path(other_incident)

      expect(response).to have_http_status(:not_found)
    end
  end

end
