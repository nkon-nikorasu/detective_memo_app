require 'rails_helper'

RSpec.describe Memo, type: :model do
  describe "バリデーション" do
    it "すべての値が正しければ有効" do
      memo = build(:memo)

      expect(memo).to be_valid
    end

    describe "body" do
      it "bodyがない場合は無効" do
        memo = build(:memo, body: nil)

        expect(memo).to be_invalid
      end

      it "bodyが空文字の場合は無効" do
        memo = build(:memo, body: "")

        expect(memo).to be_invalid
      end

      it "bodyが10000文字以内なら有効" do
        memo = build(:memo, body: "あ" * 10_000)

        expect(memo).to be_valid
      end

      it "bodyが10001文字なら無効" do
        memo = build(:memo, body: "あ" * 10_001)

        expect(memo).to be_invalid
      end
    end
  end
end
