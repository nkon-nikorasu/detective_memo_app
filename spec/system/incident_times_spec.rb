require 'rails_helper'

RSpec.describe "IncidentTimes", type: :system do
  let(:user) { create(:user) }
  let(:incident) { create(:incident, user: user) }

  before do
    login_as(user)
  end

  describe "時系列の新規作成" do
    context "入力内容が正しい場合" do
      it "時系列を作成できる" do
        visit incident_incident_times_path(incident)

        # フォームを表示
        click_button "登録"

        within "#time-record-form" do
          fill_in "incident_time_year", with: "2026"
          fill_in "incident_time_month", with: "9"
          fill_in "incident_time_date", with: "10"
          fill_in "incident_time_hour", with: "12"
          fill_in "incident_time_minute", with: "30"
          fill_in "incident_time_second", with: "15"
          fill_in "incident_time_body", with: "事件が発生した"

          click_button "登録"
        end

        # Turboなどの処理完了を待つ
        expect(page).to have_content("事件が発生した")

        incident_time = IncidentTime.last

        expect(incident_time).to be_present
        expect(incident_time.year).to eq(2026)
        expect(incident_time.month).to eq(9)
        expect(incident_time.date).to eq(10)
        expect(incident_time.hour).to eq(12)
        expect(incident_time.minute).to eq(30)
        expect(incident_time.second).to eq(15)
        expect(incident_time.body).to eq("事件が発生した")
      end
    end

    context "本文が空の場合" do
      it "時系列を作成できない" do
        visit incident_incident_times_path(incident)

        click_button "登録"

        within "#time-record-form" do
          fill_in "incident_time_year", with: "2026"
          fill_in "incident_time_month", with: "9"
          fill_in "incident_time_date", with: "10"
          fill_in "incident_time_body", with: ""

          click_button "登録"
        end

        expect(page).to have_content("行動・移動を入力してください")

        expect(
          IncidentTime.where(incident: incident).count
        ).to eq(0)
      end
    end
  end
end
