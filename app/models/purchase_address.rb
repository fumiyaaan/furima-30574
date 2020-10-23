class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :postal_number, :prefecture, :city, :house_number, :building_name, :phone_number

 
  POSTAL_NUMBER_REGEX = /\A\d{3}[-]\d{4}\z/.freeze
  validates :postal_number, presence: true, with: POSTAL_NUMBER_REGEX
  validates :prefecture_id, presence: true, numericality: { other_than: 0, message: 'Select' }
  validates :city, presence: true
  validates :house_number, presence: true
  PHONE_NUMBER_REGEX = [0-9]{,11}
  validates :phone_number, presence: true, with: PHONE_NUMBER_REGEX


  def save
    Adress.create(postal_number: postal_number, prefecture: prefecture, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number)
  end
end