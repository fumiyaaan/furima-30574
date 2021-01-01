require 'rails_helper'

RSpec.describe '商品出品', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
  end

  context '商品の出品ができるとき' do
    it 'ログインしたユーザーは商品を出品できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click

      # 商品出品ページへ移動するボタンがあることを確認する
      expect(page).to have_content('出品する')

      # 商品出品ページへ移動する
      visit new_item_path

      # フォームに情報を入力する
      fill_in 'item-name', with: @item.name
      fill_in 'item-info', with: @item.description
      select 'メンズ', from: 'item[category_id]'
      select '新品、未使用', from: 'item[condition_id]'
      select '着払い(購入者負担)', from: 'item[postage_payer_id]'
      select '北海道', from: 'item[prefecture_id]'
      select '1~2日で発送', from: 'item[transport_day_id]'
      fill_in 'item-price', with: @item.price

      # 出品するボタンを押すとItemモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(1)

      # トップページに遷移することを確認する
      expect(current_path).to eq root_path

      # トップページには先ほど出品した商品が存在することを確認する（商品名）
      expect(page).to have_content(@item.name)

      # トップページには先ほど出品した商品が存在することを確認する（価格）
      expect(page).to have_content(@item.price)
    end
  end

  context '商品の出品ができないとき' do
    it '間違った情報をフォームに入力した場合出品できない' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click

      # 商品出品ページへ移動する
      visit new_item_path

      # フォームに間違った情報を入力する
      fill_in 'item-name', with: ''
      fill_in 'item-info', with: ''
      select 'メンズ', from: ''
      select '新品、未使用', from: ''
      select '着払い(購入者負担)', from: ''
      select '北海道', from: ''
      select '1~2日で発送', from: ''
      fill_in 'item-price', with: ''

      # 出品するボタンを押してもItemモデルのカウントは上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)

      # 商品出品ページへ遷移されることを確認する
      expect(current_path).to eq '/items'
    end
  end
end

RSpec.describe '商品内容編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
  end

  context '商品内容を編集できるとき' do
    it 'ログインしたユーザーは自分が出品した商品の内容を編集できる' do
      # @itemを出品したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @item.user.email
      fill_in 'password', with: @item.user.password
      find('input[name="commit"]').click

      # @itemの詳細ページへ移動する
      visit item_path(@item)

      # @itemの編集ページへ移動する
      visit edit_item_path(@item)

      # 商品内容を編集する
      fill_in 'item-name', with: "#{@item.name}+（編集後）"
      fill_in 'item-info', with: "#{@item.description}+（編集後）"

      # 編集してもItemモデルのカウントは変わらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)

      # @itemの詳細ページへ遷移されることを確認する
      expect(current_path).to eq item_path(@item)

      # トップページに移動する
      visit root_path

      # トップページには先ほど編集した編集した商品が存在することを確認する（商品名）
      expect(page).to have_content(@item.name)
    end
  end

  context '商品内容を編集できないとき' do
    it 'ログインしたユーザーは自分以外が出品した商品の編集ページへ移動することができない' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click

      # @itemの詳細ページへ移動する
      visit item_path(@item)

      # @spotの詳細ページ上に"商品の編集"ボタンがないことを確認する
      expect(page).to have_no_content('商品の編集')
    end
  end

  it 'ログインしていないと商品の編集ページに移動することができない' do
    # トップページに移動する
    visit root_path

    # @itemの詳細ページへ移動する
    visit item_path(@item)

    # @spotの詳細ページ上に「商品の編集」ボタンがないことを確認する
    expect(page).to have_no_content('商品の編集')
  end
end

RSpec.describe '商品削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
  end

  context '出品した商品を削除できるとき' do
    it 'ログインしたユーザーは自らが出品した商品の削除ができる' do
      # @itemを出品したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @item.user.email
      fill_in 'password', with: @item.user.password
      find('input[name="commit"]').click

      # @itemの詳細ページへ移動する
      visit item_path(@item)

      # @itemの詳細ページ上に「削除」ボタンがあることを確認する
      expect(page).to have_content('削除')

      # 「削除」ボタンを押すとItemモデルのカウントが1減ることを確認する
      expect do
        find_link('削除', href: item_path(@item)).click
      end.to change { Item.count }.by(-1)

      # トップページに遷移する
      expect(current_path).to eq root_path

      # トップページに先ほど削除した商品が存在しないことを確認する（商品名）
      expect(page).to have_no_content(@item.name)
    end
  end

  context '出品した商品を削除できないとき' do
    it 'ログインしたユーザーは自分以外が出品した商品の削除ができない' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click

      # @itemの詳細ページへ移動する
      visit item_path(@item)

      # @itemの詳細ページ上に「削除」ボタンがないことを確認する
      expect(page).to have_no_content('削除')
    end
  end

  it 'ログインしていないと削除ができない' do
    # トップページに移動する
    visit root_path

    # @itemの詳細ページへ移動する
    visit item_path(@item)

    # @itemの詳細ページ上に「削除」ボタンがないことを確認する
    expect(page).to have_no_content('削除')
  end
end
