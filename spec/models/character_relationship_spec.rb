require 'rails_helper'

RSpec.describe CharacterRelationship, type: :model do
  let(:source_character) { create(:character) }
  let(:target_character) { create(:character) }

  let(:relationship) do
    build(
      :character_relationship,
      source_character: source_character,
      target_character: target_character
    )
  end
  describe "バリデーション" do
    describe "relation" do
      it "relationが存在すれば有効" do
        relationship.relation = "友人"

        expect(relationship).to be_valid
      end

      it "relationが空なら無効" do
        relationship.relation = nil

        expect(relationship).to be_invalid
      end
    end

    describe "source_to_target_impression" do
      it "10文字なら有効" do
        relationship.source_to_target_impression = "あ" * 10


        expect(relationship).to be_valid
      end

      it "11文字なら無効" do
        relationship.source_to_target_impression = "あ" * 11

        expect(relationship).to be_invalid
      end
    end

    describe "target_to_source_impression" do
      it "10文字なら有効" do
        relationship.target_to_source_impression = "あ" * 10

        expect(relationship).to be_valid
      end

      it "11文字なら無効" do
        relationship.target_to_source_impression = "あ" * 11


        expect(relationship).to be_invalid
      end
    end

    describe "characters_must_be_different" do
      it "本人と相手が別の人物なら有効" do
        expect(relationship).to be_valid
      end

      it "本人と相手が同じ人物なら無効" do
        relationship.target_character = source_character

        expect(relationship).to be_invalid
      end
    end

    describe "relationship_must_be_unique" do
      let(:another_character) { create(:character) }

      before do
        create(
          :character_relationship,
          source_character: source_character,
          target_character: target_character
        )
      end

      it "同じ向きの人物関係は重複して登録できない" do
        duplicate_relationship = build(
          :character_relationship,
          source_character: source_character,
          target_character: target_character
        )

        expect(duplicate_relationship).to be_invalid
      end

      it "逆向きの人物関係も重複して登録できない" do
        reverse_relationship = build(
          :character_relationship,
          source_character: target_character,
          target_character: source_character
        )

        expect(reverse_relationship).to be_invalid
      end

      it "別の人物との関係なら登録できる" do
        another_relationship = build(
          :character_relationship,
          source_character: source_character,
          target_character: another_character
        )

        expect(another_relationship).to be_valid
      end
    end
  end

  describe "#other_character" do
    it "source_characterを渡すとtarget_characterを返す" do
      expect(relationship.other_character(source_character)).to eq(target_character)
    end

    it "target_characterを渡すとsource_characterを返す" do
      expect(relationship.other_character(target_character)).to eq(source_character)
    end
  end

  describe "#impression_from" do
    it "source_characterを渡すとsource_to_target_impressionを返す" do
      relationship.source_to_target_impression = "信頼している"

      expect(
        relationship.impression_from(source_character)
      ).to eq("信頼している")
    end

    it "target_characterを渡すとtarget_to_source_impressionを返す" do
      relationship.target_to_source_impression = "頼りになる"

      expect(
        relationship.impression_from(target_character)
      ).to eq("頼りになる")
    end
  end
end
