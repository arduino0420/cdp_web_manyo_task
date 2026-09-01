require 'rails_helper'

RSpec.describe Labeling, type: :model do
  describe '関連付け' do
    it 'タスクとラベルがあれば有効である' do
      labeling = FactoryBot.build(:labeling)

      expect(labeling).to be_valid
    end
  end
end