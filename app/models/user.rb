class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [ :google_oauth2 ]
  has_many :incidents, dependent: :destroy

  def self.from_omniauth(auth)
    # ① Google側でメール認証が済んでいないアカウントは拒否（なりすまし対策）
    return nil if auth.provider == "google_oauth2" && !auth.info.email_verified
    # ② このアプリはemail必須なので、空なら拒否
    return nil if auth.info.email.blank?

    # ③ (provider, uid) で既存ユーザーを検索 → 2回目以降のログインはここで終了
    user = find_by(provider: auth.provider, uid: auth.uid)
    return user if user

    # ④ 同じメアドの別ユーザーがいたら拒否（アカウント乗っ取り防止）
    return nil if User.exists?(email: auth.info.email)

    # ⑤ 初回ログイン → 新規作成
    create do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.email    = auth.info.email
      user.password = SecureRandom.hex(16)
    end
  end

  # OAuthユーザーにはパスワード入力を要求しない
  def password_required?
    super && provider.blank?
  end

  def password_changeable?
    provider.blank?
  end
end
