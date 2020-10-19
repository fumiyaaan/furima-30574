require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品がうまくいくとき' do
      it 'image, name, description, category_id, condition_id, postage_payer, prefecture_id, transport_day, priceが存在すれば出品できる' do
        @item.category_id = 2
        @item.condition_id = 2
        @item.postage_payer_id = 2
        @item.prefecture_id = 1
        @item.transport_day_id = 2
        @item.price = 1000
        expect(@item).to be_valid
      end

      it 'priceが300~9,999,999円の間であれば出品できる' do
        @item.category_id = 2
        @item.condition_id = 2
        @item.postage_payer_id = 2
        @item.prefecture_id = 1
        @item.transport_day_id = 2
        @item.price = 300
        expect(@item).to be_valid
      end

      it 'priceが半角数字での入力であれば出品できる' do
        @item.category_id = 2
        @item.condition_id = 2
        @item.postage_payer_id = 2
        @item.prefecture_id = 1
        @item.transport_day_id = 2
        @item.price = 50_000
        expect(@item).to be_valid
      end
    end

    context '商品出品がうまくいかないとき' do
      it 'imageが空だと出品できない' do
      end
      it 'nameが空だと出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'descriptionが空だと出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'priceが空だと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが300円未満の場合出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end

      it 'priceが9,999,999円超の場合出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end

      it 'priceが全角数字での入力である場合出品できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number', 'Price Out of setting range')
      end
    end
  end
end
