class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :postal_number, :prefecture_id, :city, :house_number, :building_name, :phone_number, :purchase_id, :user_id, :item_id
  
 
  POSTAL_NUMBER_REGEX = /\d{3}[-]\d{4}/.freeze              
  validates :postal_number, presence: true, format: { with: POSTAL_NUMBER_REGEX, message: 'Input correctly' }
  validates :prefecture_id, presence: true, numericality: { other_than: 0, message: 'Select' }
  validates :city, presence: true
  validates :house_number, presence: true

  PHONE_NUMBER_REGEX = /\A[0-9]{,11}\z/.freeze
  validates :phone_number, presence: true
  validates :phone_number, numericality: { with: PHONE_NUMBER_REGEX, message: 'Input only number' }
  
  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postal_number: postal_number, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end
