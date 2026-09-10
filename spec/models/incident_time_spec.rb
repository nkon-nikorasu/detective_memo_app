require 'rails_helper'

RSpec.describe IncidentTime, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe "バリデーション" do
    it "すべての値が正しければ有効" do
      incident_time = build(:incident_time)

      expect(incident_time).to be_valid
    end

    describe "year" do
      it "nilでも有効" do
        incident_time = build(:incident_time, year: nil)

        expect(incident_time).to be_valid
      end

      it "0なら有効" do
        incident_time = build(:incident_time, year: 0)

        expect(incident_time).to be_valid
      end

      it "9999なら有効" do
        incident_time = build(:incident_time, year: 9999)

        expect(incident_time).to be_valid
      end

      it "-1なら無効" do
        incident_time = build(:incident_time, year: -1)

        expect(incident_time).to be_invalid
      end

      it "10000なら無効" do
        incident_time = build(:incident_time, year: 10_000)

        expect(incident_time).to be_invalid
      end

      it "小数なら無効" do
        incident_time = build(:incident_time, year: 2026.5)

        expect(incident_time).to be_invalid
      end
    end

    describe "month" do
      it "nilでも有効" do
        incident_time = build(:incident_time, month: nil)

        expect(incident_time).to be_valid
      end

      it "1なら有効" do
        incident_time = build(:incident_time, month: 1)

        expect(incident_time).to be_valid
      end

      it "12なら有効" do
        incident_time = build(:incident_time, month: 12)

        expect(incident_time).to be_valid
      end

      it "0なら無効" do
        incident_time = build(:incident_time, month: 0)

        expect(incident_time).to be_invalid
      end

      it "13なら無効" do
        incident_time = build(:incident_time, month: 13)

        expect(incident_time).to be_invalid
      end
    end

    describe "date" do
      it "1なら有効" do
        incident_time = build(:incident_time, date: 1)

        expect(incident_time).to be_valid
      end

      it "31なら有効" do
        incident_time = build(:incident_time, date: 31)

        expect(incident_time).to be_valid
      end

      it "0なら無効" do
        incident_time = build(:incident_time, date: 0)

        expect(incident_time).to be_invalid
      end

      it "32なら無効" do
        incident_time = build(:incident_time, date: 32)

        expect(incident_time).to be_invalid
      end
    end

    describe "hour" do
      it "1なら有効" do
        incident_time = build(:incident_time, hour: 1)

        expect(incident_time).to be_valid
      end

      it "23なら有効" do
        incident_time = build(:incident_time, hour: 23)

        expect(incident_time).to be_valid
      end

      it "0なら無効" do
        incident_time = build(:incident_time, hour: 0)

        expect(incident_time).to be_invalid
      end

      it "24なら無効" do
        incident_time = build(:incident_time, hour: 24)

        expect(incident_time).to be_invalid
      end
    end

    describe "minute" do
      it "1なら有効" do
        incident_time = build(:incident_time, minute: 1)

        expect(incident_time).to be_valid
      end

      it "59なら有効" do
        incident_time = build(:incident_time, minute: 59)

        expect(incident_time).to be_valid
      end

      it "0なら無効" do
        incident_time = build(:incident_time, minute: 0)

        expect(incident_time).to be_invalid
      end

      it "60なら無効" do
        incident_time = build(:incident_time, minute: 60)

        expect(incident_time).to be_invalid
      end
    end

    describe "second" do
      it "1なら有効" do
        incident_time = build(:incident_time, second: 1)

        expect(incident_time).to be_valid
      end

      it "59なら有効" do
        incident_time = build(:incident_time, second: 59)

        expect(incident_time).to be_valid
      end

      it "0なら無効" do
        incident_time = build(:incident_time, second: 0)

        expect(incident_time).to be_invalid
      end

      it "60なら無効" do
        incident_time = build(:incident_time, second: 60)

        expect(incident_time).to be_invalid
      end
    end

    describe "body" do
      it "bodyがない場合は無効" do
        incident_time = build(:incident_time, body: nil)

        expect(incident_time).to be_invalid
      end

      it "30文字以内なら有効" do
        incident_time = build(:incident_time, body: "あ" * 30)

        expect(incident_time).to be_valid
      end

      it "31文字なら無効" do
        incident_time = build(:incident_time, body: "あ" * 31)

        expect(incident_time).to be_invalid
      end
    end
  end
end
