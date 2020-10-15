class User < ApplicationRecord
   #Include default devise modules. Others available are:
   #:confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  validates :birthday, presence: true
  PASSWORD_REGEX = /[a-z]\d/i
  validates_format_of :password, with: PASSWORD_REGEX, message: 'Include both letters and numbers'
  
  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'Full-width characters' } do
    validates :first_name
    validates :sur_name
  end

  with_options presence: true, format: { with: /\A[ァ-ン]+\z/, message: 'Full-width katakana characters' } do
    validates :sur_name_reading
    validates :first_name_reading
  end

end