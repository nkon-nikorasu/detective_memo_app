require 'rails_helper'

RSpec.describe Incident, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe "バリデーション" do
    it "すべての値が正しければ有効" do
      incident = build(:incident)

      expect(incident).to be_valid
    end

    describe "book" do
      it "bookがない場合は無効" do
        incident = build(:incident, book: nil)

        expect(incident).to be_invalid
      end

      it "bookが30文字以内なら有効" do
        incident = build(:incident, book: "あ" * 30)

        expect(incident).to be_valid
      end

      it "bookが31文字以上なら無効" do
        incident = build(:incident, book: "あ" * 31)

        expect(incident).to be_invalid
      end
    end

    describe "name" do
      it "nameが30文字以内なら有効" do
        incident = build(:incident, name: "あ" * 30)

        expect(incident).to be_valid
      end

      it "nameが31文字以上なら無効" do
        incident = build(:incident, name: "あ" * 31)

        expect(incident).to be_invalid
      end
    end

    describe "body" do
      it "bodyが10000文字以内なら有効" do
        incident = build(:incident, body: "あ" * 10_000)

        expect(incident).to be_valid
      end

      it "bodyが10001文字以上なら無効" do
        incident = build(:incident, body: "あ" * 10_001)

        expect(incident).to be_invalid
      end
    end
  end
end
