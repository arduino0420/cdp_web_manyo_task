require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }

  before do
    Task.delete_all

    visit new_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end

  describe '登録機能' do
    context 'タスクを登録した場合' do
      it '登録したタスクが表示される' do
        visit new_task_path

        fill_in 'タイトル', with: '書類作成'
        fill_in '内容', with: '企画書を作成する。'
        fill_in '終了期限', with: Date.current + 3.days
        select '中', from: '優先度'
        select '未着手', from: 'ステータス'
        click_button '登録する'

        puts "DEBUG PAGE: #{page.text}" unless page.has_content?('書類作成')

        expect(page).to have_content '書類作成'
        expect(page).to have_content '企画書を作成する。'
        expect(page).to have_content Date.current + 3.days
        expect(page).to have_content '中'
        expect(page).to have_content '未着手'
      end
    end

    context 'ラベルを選択してタスクを登録した場合' do
      let!(:label) { FactoryBot.create(:label, user: user, name: '仕事') }

      it '登録したタスクにラベルが付けられる' do
        visit new_task_path

        fill_in 'タイトル', with: 'ラベル付きタスク'
        fill_in '内容', with: 'ラベルのテスト'
        fill_in '終了期限', with: Date.current + 3.days
        select '中', from: '優先度'
        select '未着手', from: 'ステータス'

        check "task_label_ids_#{label.id}"

        click_button '登録する'

        expect(page).to have_content 'ラベル付きタスク'
        expect(page).to have_content '仕事'
      end
    end
  end

  describe '一覧表示機能' do
    let!(:first_task) do
      FactoryBot.create(
        :task,
        title: '新しいタスク',
        content: '新しいタスクの内容',
        deadline_on: Date.current + 3.days,
        priority: :中,
        status: :未着手,
        created_at: Time.current,
        user: user
      )
    end

    let!(:second_task) do
      FactoryBot.create(
        :task,
        title: '1日前のタスク',
        content: '1日前のタスクの内容',
        deadline_on: Date.current + 1.day,
        priority: :高,
        status: :着手中,
        created_at: 1.day.ago,
        user: user
      )
    end

    let!(:third_task) do
      FactoryBot.create(
        :task,
        title: '2日前のタスク',
        content: '2日前のタスクの内容',
        deadline_on: Date.current + 2.days,
        priority: :低,
        status: :完了,
        created_at: 2.days.ago,
        user: user
      )
    end

    before do
      visit tasks_path
    end

    context '一覧画面に遷移した場合' do
      it '登録済みのタスク一覧が表示される' do
        expect(page).to have_content first_task.title
        expect(page).to have_content second_task.title
        expect(page).to have_content third_task.title
      end

      it '登録済みのタスク一覧が作成日時の降順で表示される' do
        task_list = all('tbody tr')

        expect(task_list[0]).to have_content first_task.title
        expect(task_list[1]).to have_content second_task.title
        expect(task_list[2]).to have_content third_task.title
      end

      it '終了期限をクリックすると終了期限の昇順で表示される' do
        visit tasks_path(sort_deadline_on: true)

        task_list = all('tbody tr')

        expect(task_list[0]).to have_content second_task.title
        expect(task_list[1]).to have_content third_task.title
        expect(task_list[2]).to have_content first_task.title
      end

      it '優先度をクリックすると優先度の高い順で表示される' do
        visit tasks_path(sort_priority: true)

        task_list = all('tbody tr')

        expect(task_list[0]).to have_content second_task.title
        expect(task_list[1]).to have_content first_task.title
        expect(task_list[2]).to have_content third_task.title
      end

      it 'タイトルであいまい検索できる' do
        fill_in 'タイトル', with: '新しい'
        click_button '検索'

        expect(page).to have_content first_task.title
        expect(page).not_to have_content second_task.title
        expect(page).not_to have_content third_task.title
      end

      it 'ステータスで検索できる' do
        visit tasks_path(search: { status: '着手中' })

        expect(page).not_to have_content first_task.title
        expect(page).to have_content second_task.title
        expect(page).not_to have_content third_task.title
      end

      it 'ラベルで検索できる' do
        label = FactoryBot.create(:label, user: user, name: '仕事')
        first_task.labels << label

        visit tasks_path

        select '仕事', from: 'ラベル'
        click_button '検索'

        expect(page).to have_content first_task.title
        expect(page).not_to have_content second_task.title
        expect(page).not_to have_content third_task.title
      end

      it 'タイトルとステータスの両方で検索できる' do
        fill_in 'タイトル', with: '新しい'
        select '未着手', from: 'ステータス'
        click_button '検索'

        expect(page).to have_content first_task.title
        expect(page).not_to have_content second_task.title
        expect(page).not_to have_content third_task.title
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it 'そのタスクの内容が表示される' do
        task = FactoryBot.create(:task, user: user)

        visit task_path(task)

        expect(page).to have_content '企画書を作成する。'
      end
    end
  end
end