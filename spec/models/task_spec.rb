require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'is invalid without a title' do
    task = Task.new(title: '', content: '企画書を作成する。')

    expect(task).not_to be_valid
  end

  it 'is invalid without content' do
    task = Task.new(title: '書類作成', content: '')

    expect(task).not_to be_valid
  end

  it 'is valid with a title and content' do
    task = Task.new(title: '書類作成', content: '企画書を作成する。')

    expect(task).to be_valid
  end
end