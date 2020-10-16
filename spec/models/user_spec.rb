require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'nickname, email, password, password_confirmation, sur_name, first_name, sur_name_reading, first_name_reading, birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it 'passwordが半角英数字6文字以上であれば登録できる' do
        @user.password = 'a12345'
        @user.password_confirmation = 'a12345'
        expect(@user).to be_valid
      end

      it 'sur_nameとfirst_nameが全角（漢字・ひらがな・カタカナ）での入力であれば登録できる' do
        @user.sur_name = '加藤'
        @user.first_name = 'フリま次郎'
        expect(@user).to be_valid
      end

      it 'sur_name_readingとfirst_name_readingが全角（カタカナ）での入力であれば登録できる' do
        @user.sur_name_reading = 'カトウ'
        @user.first_name_reading = 'フリマジロウ'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      
      it 'emailに@がない場合登録できない' do
        @user.email = 'ab905com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")        
      end

      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'passwordが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが5文字以下であれば登録できない' do
        @user.password = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが半角英数字混合での入力でなければ登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end

      it 'passwordとpassword_confirmationが一致しなければ登録できない' do
        @user.password = 'c12345'
        @user.password_confirmation = 'd12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordが存在してもpassword_confirmationが空だと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'sur_nameが空だと登録できない' do
        @user.sur_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Sur name can't be blank")
      end

      it 'sur_nameが全角（漢字・ひらがな・カタカナ）での入力でなければ登録できない' do
        @user.sur_name = '123'
        @user.valid?
        expect(@user.errors.full_messages).to include('Sur name Full-width characters')
      end

      it 'first_nameが空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'first_nameが全角（漢字・ひらがな・カタカナ）での入力でなければ登録できない' do
        @user.first_name = '456'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name Full-width characters')
      end

      it 'sur_name_readingが空だと登録できない' do
        @user.sur_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Sur name reading can't be blank")
      end

      it 'sur_name_readingが全角（カタカナ）での入力でなければ登録できない' do
        @user.sur_name_reading = 'さとう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Sur name reading Full-width katakana characters')
      end

      it 'first_name_readingが空だと登録できない' do
        @user.first_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name reading can't be blank")
      end

      it 'first_name_readingが全角（カタカナ）での入力でなければ登録できない' do
        @user.first_name_reading = '次郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name reading Full-width katakana characters')
      end

      it 'birthdayが空だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
