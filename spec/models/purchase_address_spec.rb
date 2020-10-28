require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  before do
    @purchase_address = FactoryBot.build(:purchase_address)
  end

  describe '商品購入' do
    context '商品購入がうまくいくとき' do
      it '全ての値が正しく入力されていれば購入できる' do
        expect(@purchase_address).to be_valid
      end

      it 'postal_numberが半角数字で「〇〇〇-〇〇〇〇」の形で入力されていれば購入できる' do
        @purchase_address.postal_number = '123-4567'
        expect(@purchase_address).to be_valid
      end

      it 'building_nameが空でも購入できる' do
        @purchase_address.building_name = ''
        expect(@purchase_address).to be_valid
      end

      it 'phone_numberが半角数字の11桁(ハイフンなし)で入力されていれば購入できる' do
        @purchase_address.phone_number = '12345678910'
        expect(@purchase_address).to be_valid
      end
    end

    context '商品購入がうまくいかないとき' do
      it 'postal_numberが空だと購入できない' do
        @purchase_address.postal_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal number can't be blank")
      end

      it 'postal_numberが半角数字7桁(ハイフンなし)の形で入力されていれば購入できない' do
        @purchase_address.postal_number = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Postal number Input correctly')
      end

      it 'postal_numberが全角数字で入力されていれば購入できない' do
        @purchase_address.postal_number = '１２３-４５６７'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Postal number Input correctly')
      end

      it 'prefecture_idが0である場合購入できない' do
        @purchase_address.prefecture_id = 0
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Prefecture Select')
      end

      it 'cityが空だと購入できない' do
        @purchase_address.city = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end

      it 'house_numberが空だと購入できない' do
        @purchase_address.house_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("House number can't be blank")
      end

      it 'phone_numberが空だと購入できない' do
        @purchase_address.phone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが全角数字で入力されていれば購入できない' do
        @purchase_address.phone_number = '０９０１２３４５６７８'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number Input only number')
      end

      it 'tokenが空だと購入できない' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
