class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #:confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  validates :birthday, presence: true
  PASSWORD_REGEX = /[a-z]\d/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'Include both letters and numbers'

  NAME_REGEX = /\A[ぁ-んァ-ン一-龥]+\z/.freeze
  with_options presence: true, format: { with: NAME_REGEX, message: 'Full-width characters' } do
    validates :sur_name
    validates :first_name
  end

  NAME_READING_REGEX = /\A[ァ-ン]+\z/.freeze
  with_options presence: true, format: { with: NAME_READING_REGEX, message: 'Full-width katakana characters' } do
    validates :sur_name_reading
    validates :first_name_reading
  end

  has_many :items
  has_many :purchases
end