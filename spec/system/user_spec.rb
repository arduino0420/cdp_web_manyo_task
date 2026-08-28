require 'rails_helper'

RSpec.describe 'ユーザ管理機能', type: :system do
  describe 'アカウント登録機能' do
    it 'ユーザを登録できる' do
      visit new_user_path

      fill_in 'user_name', with: '新規ユーザ'
      fill_in 'user_email', with: 'new_user@example.com'
      fill_in 'user_password', with: 'TestUser_8xK4pQ9m!'
      fill_in 'user_password_confirmation', with: 'TestUser_8xK4pQ9m!'
      click_button '登録する'

      expect(page).to have_current_path(tasks_path)
      expect(User.find_by(email: 'new_user@example.com')).to be_present
    end
  end

  describe 'ログイン・ログアウト機能' do
    let!(:user) { FactoryBot.create(:user) }

    it 'ログインできる' do
      visit new_session_path

      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_button 'ログイン'

      expect(page).to have_current_path(tasks_path)
      expect(page).to have_link 'ログアウト'
    end

    it 'ログアウトできる' do
      visit new_session_path

      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_button 'ログイン'

      expect(page).to have_current_path(tasks_path)

      click_link 'ログアウト'

      expect(page).to have_current_path(new_session_path)
      expect(page).to have_link 'ログイン'
    end
  end

  describe '管理画面へのアクセス制御' do
    context '一般ユーザの場合' do
      let!(:user) { FactoryBot.create(:user) }

      before do
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button 'ログイン'

        expect(page).to have_current_path(tasks_path)
      end

      it '管理画面にアクセスできない' do
        visit admin_users_path

        expect(page).to have_content '管理者以外アクセスできません'
        expect(page).to have_current_path(tasks_path)
      end
    end

    context '管理者の場合' do
      let!(:admin) { FactoryBot.create(:user, :admin) }

      before do
        visit new_session_path
        fill_in 'session_email', with: admin.email
        fill_in 'session_password', with: admin.password
        click_button 'ログイン'

        expect(page).to have_current_path(tasks_path)
      end

      it '管理画面にアクセスできる' do
        visit admin_users_path

        expect(page).to have_content 'ユーザ一覧ページ'
        expect(page).to have_current_path(admin_users_path)
      end
    end
  end

  describe '他人のタスクへのアクセス制御' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:other_user) { FactoryBot.create(:user) }
    let!(:other_task) { FactoryBot.create(:task, user: other_user) }

    before do
      visit new_session_path
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_button 'ログイン'

      expect(page).to have_current_path(tasks_path)
    end

    it '他人のタスクを編集できない' do
      visit edit_task_path(other_task)

      expect(page).to have_content 'アクセス権限がありません'
      expect(page).to have_current_path(tasks_path)
    end
  end
end