require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  describe '登録機能' do
    context 'タスクを登録した場合' do
      it '登録したタスクが表示される' do
        visit new_task_path

        fill_in 'タイトル', with: '書類作成'
        fill_in '内容', with: '企画書を作成する。'
        click_button '登録する'

        expect(page).to have_content '書類作成'
        expect(page).to have_content '企画書を作成する。'
      end
    end
  end

  describe '一覧表示機能' do
    let!(:first_task) do
      FactoryBot.create(
        :task,
        title: '新しいタスク',
        content: '新しいタスクの内容',
        created_at: Time.current
      )
    end

    let!(:second_task) do
      FactoryBot.create(
        :task,
        title: '1日前のタスク',
        content: '1日前のタスクの内容',
        created_at: 1.day.ago
      )
    end

    let!(:third_task) do
      FactoryBot.create(
        :task,
        title: '2日前のタスク',
        content: '2日前のタスクの内容',
        created_at: 2.days.ago
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
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it 'そのタスクの内容が表示される' do
        task = FactoryBot.create(:task)

        visit task_path(task)

        expect(page).to have_content '企画書を作成する。'
      end
    end
  end
end