require 'rails_helper'

RSpec.describe Label, type: :model do
  describe 'バリデーション' do
    it '名前があれば有効である' do
      label = FactoryBot.build(:label)

      expect(label).to be_valid
    end

    it '名前がなければ無効である' do
      label = FactoryBot.build(:label, name: nil)

      expect(label).not_to be_valid
    end
  end
end