require "rails_helper"

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  describe "#failure" do
    it "ログイン画面へエラーメッセージ付きでリダイレクトすること" do
      expect(controller).to receive(:redirect_to).with(
        new_user_session_path,
        alert: "認証に失敗しました。もう一度お試しください。"
      )

      controller.failure
    end
  end
end
