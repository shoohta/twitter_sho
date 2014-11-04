class User < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  has_secure_password
  validates :password, length: { minimum: 6 }

  has_many :tweets
  def set_image(file)
    if !file.nil?
    # ファイル名
      file_name = file.original_filename
      #画像をアップロード
      File.open("public/docs/#{file_name}", 'wb'){|f| f.write(file.read)}
      #データベースにファイルを保存する準備
      self.image = file_name
    end
  end
end