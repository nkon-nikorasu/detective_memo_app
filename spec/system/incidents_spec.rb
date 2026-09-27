RSpec.describe "Incident", type: :system do
  let(:user) { create(:user) }

  before do
    login_as(user)
  end

  describe "事件メモの新規作成" do
    context "入力内容が正しい場合" do
      it "事件メモを作成できる" do
        visit new_incident_path

        fill_in "事件名", with: "殺人事件"
        select "殺人", from: "タグ"
        fill_in "説明", with: "事件についてのテスト内容"

        click_button "登録"
        expect(page).to have_field("事件名", with: "殺人事件")
      end
    end
  end
end
