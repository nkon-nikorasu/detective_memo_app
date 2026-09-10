require 'rails_helper'

RSpec.describe "Characters", type: :system do
  let(:user) { create(:user) }
  let(:incident) { create(:incident, user: user) }

  before do
    login_as(user)
  end

  describe "登場人物の新規作成" do
    context "入力内容が正しい場合" do
      it "登場人物を作成できる" do
        visit incident_characters_path(incident)
        click_button "登録"
        within "#character-form" do
          fill_in "人物名", with: "湯川学"
          fill_in "年齢", with: "36"
          fill_in "職業", with: "探偵"
          fill_in "人物像", with: "帝都大学の准教授"
          select "男", from: "性別"
          click_button "登録"
        end
        expect(page).to have_content("湯川学")
        character = Character.last

        expect(character.name).to eq("湯川学")
        expect(character.age).to eq(36)
        expect(character.role).to eq("探偵")
        expect(character.body).to eq("帝都大学の准教授")
      end
    end

    context "名前が空の場合" do
      it "登場人物を作成できない" do
        visit incident_characters_path(incident)
        click_button "登録"
        within "#character-form" do
          fill_in "人物名", with: ""
          fill_in "人物像", with: "人物の説明"

          expect {
            click_button "登録"
          }.not_to change(Character, :count)
        end
        expect(page).to have_content("人物名を入力してください")
      end
    end
  end

  #pending "add some scenarios (or delete) #{__FILE__}"
end
