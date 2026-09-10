require 'rails_helper'

RSpec.describe "Memos", type: :system do
  let(:user) { create(:user) }
  let(:incident) { create(:incident, user: user) }

  before do
    login_as(user)
  end

  describe "推理メモの新規作成" do
    context "入力内容が正しい場合" do
      it "推理メモを作成できる" do
        visit incident_memos_path(incident)

        # フォーム表示
        click_button "登録"

        within "#memo-form" do
          fill_in "メモ", with: "犯人はAではないかと考えた"
          select "推理", from: "タグ"

          click_button "登録"
        end

        # Turboなどの処理完了を待つ
        expect(page).to have_content("犯人はAではないかと考えた")

        memo = Memo.last

        expect(memo).to be_present
        expect(memo.body).to eq("犯人はAではないかと考えた")
        expect(memo.deduction?).to be true
        expect(memo.incident).to eq(incident)
      end
    end

    context "本文が空の場合" do
      it "推理メモを作成できない" do
        visit incident_memos_path(incident)

        click_button "登録"

        within "#memo-form" do
          fill_in "メモ", with: ""

          click_button "登録"
        end

        expect(page).to have_content("メモを入力してください")
        expect(Memo.where(incident: incident).count).to eq(0)
      end
    end
  end
end
