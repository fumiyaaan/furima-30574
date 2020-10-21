class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :transport_day

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :category_id
    validates :condition_id
    validates :postage_payer_id
    validates :prefecture_id
    validates :transport_day_id
    validates :price
  end

  validates :price, numericality: { message: 'Half-width number' }

  validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 10_000_000, message: 'Out of setting range' }

  # ジャンルの選択が「---」の時は保存できないバリデーション
  validates :category_id, numericality: { other_than: 1, message: 'Select' }
  validates :condition_id, numericality: { other_than: 1, message: 'Select' }
  validates :postage_payer_id, numericality: { other_than: 1, message: 'Select' }
  validates :prefecture_id, numericality: { other_than: 0, message: 'Select' }
  validates :transport_day_id, numericality: { other_than: 1, message: 'Select' }

  belongs_to :user
  has_one :purchase
  has_one_attached :image
end
