require 'rails_helper'

RSpec.describe PostagePayer, type: :model do
  describe '商品出品' do
    context '商品出品がうまくいくとき' do
      it 'postage_payer_idが1以外であれば出品できる' do
        @item = FactoryBot.build(:item)
        @item.category_id = 2
        @item.condition_id = 2
        @item.postage_payer_id = 2
        @item.prefecture_id = 2
        @item.transport_day_id = 2
        @item.price = 1000
        expect(@item).to be_valid
      end
    end

    context '商品出品がうまくいかないとき' do
      it 'postage_payer_idが1である場合出品できない' do
        @item = FactoryBot.build(:item)
        @item.category_id = 2
        @item.condition_id = 2
        @item.postage_payer_id = 1
        @item.prefecture_id = 2
        @item.transport_day_id = 2
        @item.price = 1000
        @item.valid?
        expect(@item.errors.full_messages).to include('Postage payer Select')
      end
    end
  end
end
