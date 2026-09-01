require 'rails_helper'

RSpec.describe 'ラベル管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }

  before do
    visit new_session_path
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: user.password
    click_button 'ログイン'

    expect(page).to have_current_path(tasks_path)
  end

  describe '一覧表示機能' do
    let!(:label) { FactoryBot.create(:label, user: user, name: '仕事') }

    it '自分が作成したラベルが表示される' do
      visit labels_path

      expect(page).to have_content '仕事'
    end
  end

  describe '登録機能' do
    it 'ラベルを登録できる' do
      visit new_label_path

      fill_in 'label_name', with: '勉強'
      click_button '登録する'

      expect(page).to have_current_path(labels_path)
      expect(page).to have_content 'ラベルを登録しました'
      expect(page).to have_content '勉強'
    end
  end

  describe '編集機能' do
    let!(:label) { FactoryBot.create(:label, user: user, name: '変更前') }

    it 'ラベルを編集できる' do
      visit labels_path

      click_link '編集'
      fill_in 'label_name', with: '変更後'
      click_button '更新する'

      expect(page).to have_current_path(labels_path)
      expect(page).to have_content 'ラベルを更新しました'
      expect(page).to have_content '変更後'
    end
  end

  describe '削除機能' do
    let!(:label) { FactoryBot.create(:label, user: user, name: '削除するラベル') }

    it 'ラベルを削除できる' do
      visit labels_path

      accept_confirm '本当に削除してもよろしいですか？' do
        click_link '削除'
      end

      expect(page).to have_current_path(labels_path)
      expect(page).to have_content 'ラベルを削除しました'
      expect(page).not_to have_content '削除するラベル'
    end
  end
end