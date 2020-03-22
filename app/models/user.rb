class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  attachment :profile_image

  validates :name, length: { in: 2..20 }
  validates :introduction, length: {maximum:50 }

end

#:database_authenticatable（パスワードの正確性を検証）
#:registerable（ユーザ登録や編集、削除）
#:recoverable（パスワードをリセット）
#:rememberable（ログイン情報を保存）
#:validatable（emailのフォーマットなどのバリデーション）

#今回は実装しないrecoverableやrememberableも含まれていますが、デフォルトの記述なので、このままで進めていきます。