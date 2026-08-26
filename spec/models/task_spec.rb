require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    Task.delete_all
  end

  it 'is invalid without a title' do
    task = FactoryBot.build(:task, title: '')

    expect(task).not_to be_valid
  end

  it 'is invalid without content' do
    task = FactoryBot.build(:task, content: '')

    expect(task).not_to be_valid
  end

  it 'is invalid without a deadline_on' do
    task = FactoryBot.build(:task, deadline_on: nil)

    expect(task).not_to be_valid
  end

  it 'is invalid without a priority' do
    task = FactoryBot.build(:task, priority: nil)

    expect(task).not_to be_valid
  end

  it 'is invalid without a status' do
    task = FactoryBot.build(:task, status: nil)

    expect(task).not_to be_valid
  end

  it 'is valid with all required attributes' do
    task = FactoryBot.build(:task)

    expect(task).to be_valid
  end

  describe '終了期限のソート' do
    let!(:task) { FactoryBot.create(:task) }
    let!(:second_task) { FactoryBot.create(:second_task) }
    let!(:third_task) { FactoryBot.create(:third_task) }

    it '終了期限の昇順に並ぶ' do
      expect(Task.sort_deadline_on).to eq [
        third_task,
        second_task,
        task
      ]
    end
  end

  describe '優先度のソート' do
    let!(:task) { FactoryBot.create(:task) }
    let!(:second_task) { FactoryBot.create(:second_task) }
    let!(:third_task) { FactoryBot.create(:third_task) }

    it '優先度の高い順に並ぶ' do
      expect(Task.sort_priority).to eq [
        second_task,
        task,
        third_task
      ]
    end
  end

  describe 'タイトル検索' do
    let!(:task) { FactoryBot.create(:task) }
    let!(:second_task) { FactoryBot.create(:second_task) }
    let!(:third_task) { FactoryBot.create(:third_task) }

    it 'タイトルをあいまい検索できる' do
      expect(Task.search_title('書類')).to include(task)
      expect(Task.search_title('書類')).not_to include(second_task, third_task)
    end
  end

  describe 'ステータス検索' do
    let!(:task) { FactoryBot.create(:task) }
    let!(:second_task) { FactoryBot.create(:second_task) }
    let!(:third_task) { FactoryBot.create(:third_task) }

    it 'ステータスで検索できる' do
      expect(Task.search_status('未着手')).to include(task)
      expect(Task.search_status('未着手')).not_to include(second_task, third_task)
    end
  end

  describe 'タイトルとステータスの検索' do
    let!(:task) { FactoryBot.create(:task) }
    let!(:second_task) { FactoryBot.create(:second_task) }
    let!(:third_task) { FactoryBot.create(:third_task) }

    it 'タイトルとステータスの両方で絞り込める' do
      result = Task.search_title('書類').search_status('未着手')

      expect(result).to include(task)
      expect(result).not_to include(second_task, third_task)
    end
  end
end