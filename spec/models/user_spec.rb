require 'rails_helper'

RSpec.describe User, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe 'バリデーションチェック' do
    it "正しい情報ならユーザーを作成できる" do
      user = build(:user)

      expect(user).to be_valid
    end

    it "メールアドレスがない場合は無効" do
      user = build(:user, email: nil)

      expect(user).to be_invalid
    end

    it "パスワードがない場合は無効" do
      user = build(:user, password: nil)

      expect(user).to be_invalid
    end

    it "メールアドレスが重複している場合は無効" do
      user = create(:user)
      duplicate_user = build(:user, email: user.email)

      expect(duplicate_user).to be_invalid
    end
  end
end
