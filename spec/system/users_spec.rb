require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページへ遷移する' do
      # トップページに遷移する
      visit root_path

      # トップページにユーザー新規登録ページへ移動するボタンがあることを確認する
      expect(page).to have_content('新規登録')

      # 新規登録ページへ移動する
      visit new_user_registration_path

      # ユーザー情報を入力する
      fill_in 'nickname', with: @user.nickname
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password_confirmation
      fill_in 'first-name', with: @user.first_name
      fill_in 'last-name', with: @user.sur_name
      fill_in 'first-name-kana', with: @user.first_name_reading
      fill_in 'last-name-kana', with: @user.sur_name_reading
      select '1996', from: 'user[birthday(1i)]'
      select '10', from: 'user[birthday(2i)]'
      select '22', from: 'user[birthday(3i)]'

      # 会員登録ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)

      # トップページへ遷移したことを確認する
      expect(current_path).to eq root_path

      # ログアウトボタンが表示されていることを確認する
      expect(page).to have_content('ログアウト')

      # 新規登録ページへ移動するボタンと、ログインページへ移動するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができず新規登録ページへ戻ってくる' do
      # トップページに遷移する
      visit root_path

      # トップページにユーザー新規登録ページへ移動するボタンがあることを確認する
      expect(page).to have_content('新規登録')

      # 新規登録ページへ移動する
      visit new_user_registration_path

      # ユーザー情報を入力する
      fill_in 'nickname', with: ""
      fill_in 'email', with: ""
      fill_in 'password', with: ""
      fill_in 'password-confirmation', with: ""
      fill_in 'first-name', with: ""
      fill_in 'last-name', with: ""
      fill_in 'first-name-kana', with: ""
      fill_in 'last-name-kana', with: ""
      select "", from: 'user[birthday(1i)]'
      select "", from: 'user[birthday(2i)]'
      select "", from: 'user[birthday(3i)]'

      # 会員登録ボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)

      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq "/users"
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path

      # トップページにログインページに移動するボタンがあることを確認する
      expect(page).to have_content('ログイン')

      # ログインページへ遷移する
      visit new_user_session_path

      # 正しいユーザー情報を入力する
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password

      # ログインボタンを押す
      find('input[name="commit"]').click

      # トップページへ遷移したことを確認する
      expect(current_path).to eq root_path

      # ログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')

      # ユーザー新規登録ページへ移動するボタンやログインページへ移動するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインできない' do
      # トップページに移動する
      visit root_path

      # トップページにログインページに移動するボタンがあることを確認する
      expect(page).to have_content('ログイン')

      # ログインページへ遷移する
      visit new_user_session_path

      # 正しいユーザー情報を入力する
      fill_in 'email', with: ""
      fill_in 'password', with: ""

      # ログインボタンを押す
      find('input[name="commit"]').click

      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end