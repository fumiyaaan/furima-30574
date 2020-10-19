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
    validates :category
    validates :condition
    validates :postage_payer
    validates :prefecture
    validates :transport_day
    validates :price
  end

  # PRICE_REGEX = /\A[0-9]+\z/.freeze
  # validates_format_of :price, with: PRICE_REGEX, message: 'Half-width number'

  validates :price, numericality: { message: 'Half-width number' }

  validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 10_000_000, message: 'Out of setting range' }
  # 商品名でテスト
  # validates_format_of :name, with: PRICE_REGEX, message: '商品名でテスト'
  # validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 10000000, message: 'Out of setting range' }

  # ジャンルの選択が「---」の時は保存できないバリデーション
  validates :category_id, numericality: { other_than: 1, message: 'Select' }
  validates :condition_id, numericality: { other_than: 1, message: 'Select' }
  validates :postage_payer_id, numericality: { other_than: 1, message: 'Select' }
  validates :prefecture_id, numericality: { other_than: 0, message: 'Select' }
  validates :transport_day_id, numericality: { other_than: 1, message: 'Select' }

  belongs_to :user
  has_one_attached :image
end
