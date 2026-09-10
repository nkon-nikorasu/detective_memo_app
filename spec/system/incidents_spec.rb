RSpec.describe "Incident", type: :system do
  let(:user) { create(:user) }

  before do
    login_as(user)
  end

  describe "事件メモの新規作成" do
    context "入力内容が正しい場合" do
      it "事件メモを作成できる" do
        visit new_incident_path

        fill_in "書籍名", with: "容疑者Xの献身"
        fill_in "事件名", with: "殺人事件"
        select "殺人", from: "タグ"
        fill_in "説明", with: "事件についてのテスト内容"

        click_button "登録"

        expect(page).to have_field("書籍名", with: "容疑者Xの献身")
        expect(page).to have_field("事件名", with: "殺人事件")
      end
    end

    context "本のタイトルが空の場合" do
      it "事件メモを作成できない" do
        visit new_incident_path

        fill_in "書籍名", with: ""
        fill_in "事件名", with: "殺人事件"
        select "殺人", from: "タグ"
        fill_in "説明", with: "事件についてのテスト内容"

        click_button "登録"

        expect(page).to have_content("書籍名を入力してください")
      end
    end
  end
end