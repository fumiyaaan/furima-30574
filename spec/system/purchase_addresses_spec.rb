require 'rails_helper'

RSpec.describe "商品購入", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
  end

  context '商品の購入ができるとき' do
    it 'ログインしたユーザーは自分以外が出品した商品を購入することができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click

      # @itemの詳細ページへ移動する
      visit item_path(@item)

      # @itemの詳細ページ上に「購入画面に進む」ボタンがあることを確認する
      expect(page).to have_content('購入画面に進む')

      # 商品購入画面に移動する
      visit item_purchases_path(@item)

      # フォームに情報を入力する
      fill_in 'card-number', with: 4242424242424242
      fill_in 'card-exp-month', with: 12
      fill_in 'card-exp-year', with: 24
      fill_in 'card-cvc', with: 123
      fill_in 'postal-code', with: 123-4567
      select '北海道', from: 'purchase_address[prefecture_id]'
      fill_in 'city', with: "横浜市"
      fill_in 'addresses', with: "1番地2"
      fill_in 'phone-number', with: "09012345678"

      # 「購入」ボタンを押すとPurchaseモデルのカウントが1上がることを確認する
      expect{find('input[name="commit"]').click}.to change { Purchase.count }.by(1)

      # トップページに遷移されることを確認する
      expect(current_path).to eq root_path
    end
  end

  context '商品の購入ができないとき' do
    it 'ログインしたユーザーは自らが出品した商品を購入することができない' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @item.user.email
      fill_in 'password', with: @item.user.password
      find('input[name="commit"]').click

      # @itemの詳細ページへ移動する
      visit item_path(@item)

      # @itemの詳細ページ上に「購入画面に進む」ボタンがないことを確認する
      expect(page).to have_no_content('購入画面に進む')
    end

    it 'ログインしていないと商品の購入画面に進むことができない' do
      # トップページへ移動する
      visit root_path

      # @itemの詳細ページへ移動する
      visit item_path(@item)

      # @itemの詳細ページ上に「購入画面に進む」ボタンがないことを確認する
      expect(page).to have_no_content('購入画面に進む')
    end
  end
end
