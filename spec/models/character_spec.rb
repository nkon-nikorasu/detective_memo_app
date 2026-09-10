require 'rails_helper'

RSpec.describe Character, type: :model do
  describe "バリデーション" do
    it "すべての値が正しければ有効" do
      character = build(:character)

      expect(character).to be_valid
    end

    describe "name" do
      it "nameがない場合は無効" do
        character = build(:character, name: nil)

        expect(character).to be_invalid
      end

      it "nameが10文字以内なら有効" do
        character = build(:character, name: "あ" * 10)

        expect(character).to be_valid
      end

      it "nameが11文字以上なら無効" do
        character = build(:character, name: "あ" * 11)

        expect(character).to be_invalid
      end
    end

    describe "age" do
      it "ageが整数なら有効" do
        character = build(:character, age: 30)

        expect(character).to be_valid
      end

      it "ageがnilでも有効" do
        character = build(:character, age: nil)

        expect(character).to be_valid
      end

      it "ageが0なら有効" do
        character = build(:character, age: 0)

        expect(character).to be_valid
      end

      it "ageが9999なら有効" do
        character = build(:character, age: 9999)

        expect(character).to be_valid
      end

      it "ageがマイナスなら無効" do
        character = build(:character, age: -1)

        expect(character).to be_invalid
      end

      it "ageが10000以上なら無効" do
        character = build(:character, age: 10_000)

        expect(character).to be_invalid
      end

      it "ageが整数でなければ無効" do
        character = build(:character, age: 10.5)

        expect(character).to be_invalid
      end
    end

    describe "role" do
      it "roleが10文字以内なら有効" do
        character = build(:character, role: "あ" * 10)

        expect(character).to be_valid
      end

      it "roleが11文字以上なら無効" do
        character = build(:character, role: "あ" * 11)

        expect(character).to be_invalid
      end
    end

    describe "body" do
      it "bodyがない場合は無効" do
        character = build(:character, body: nil)

        expect(character).to be_invalid
      end

      it "bodyが5000文字以内なら有効" do
        character = build(:character, body: "あ" * 5000)

        expect(character).to be_valid
      end

      it "bodyが5001文字以上なら無効" do
        character = build(:character, body: "あ" * 5001)

        expect(character).to be_invalid
      end
    end
  end
end
