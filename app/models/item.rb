class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :transport_day

  validates :image, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :condition, presence: true
  validates :postage_payer, presence: true
  validates :prefecture, presence: true
  validates :transport_day, presence: true

  PRICE_REGEX = /\A[0-9]+\z/.freeze
  with_options presence: true, numericality: { greater_than: 299, less_than: 10000000 }, format: { with: PRICE_REGEX, message: 'Half-width number' } do
    validates :price
  end

  #ジャンルの選択が「---」の時は保存できないバリデーション
  validates :category_id, numericality: { other_than: 1 }
  validates :condition_id, numericality: { other_than: 1 }
  validates :postage_payer_id, numericality: { other_than: 1 }
  validates :prefecture_id, numericality: { other_than: 0 }
  validates :transport_day_id, numericality: { other_than: 1 }

  belongs_to :user
  has_one_attached :image
end