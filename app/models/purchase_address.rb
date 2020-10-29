class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :token, :postal_number, :prefecture_id, :city, :house_number, :building_name, :phone_number, :purchase_id, :user_id, :item_id

  with_options presence: true do
    validates :token
    POSTAL_NUMBER_REGEX = /\d{3}[-]\d{4}/.freeze
    validates :postal_number, format: { with: POSTAL_NUMBER_REGEX, message: 'Input correctly' }
    validates :prefecture_id, numericality: { other_than: 0, message: 'Select' }
    validates :city
    validates :house_number
    PHONE_NUMBER_REGEX = /\A[0-9]{,11}\z/.freeze
    validates :phone_number, format: { with: PHONE_NUMBER_REGEX, message: 'Input only number and within 11 digits' }
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postal_number: postal_number, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end
