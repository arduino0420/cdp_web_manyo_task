require 'rails_helper'

RSpec.describe User, type: :model do
  it '名前、メールアドレス、パスワードがあれば有効である' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it '名前がなければ無効である' do
    user = FactoryBot.build(:user, name: '')
    expect(user).to be_invalid
  end

  it 'メールアドレスがなければ無効である' do
    user = FactoryBot.build(:user, email: '')
    expect(user).to be_invalid
  end

  it 'パスワードが6文字未満なら無効である' do
    user = FactoryBot.build(
      :user,
      password: '12345',
      password_confirmation: '12345'
    )

    expect(user).to be_invalid
  end

  it '同じメールアドレスは大文字小文字を区別せず登録できない' do
    FactoryBot.create(:user, email: 'test@example.com')

    user = FactoryBot.build(:user, email: 'TEST@EXAMPLE.COM')

    expect(user).to be_invalid
  end

  it 'メールアドレスは小文字で保存される' do
    user = FactoryBot.create(:user, email: 'TEST@EXAMPLE.COM')

    expect(user.email).to eq 'test@example.com'
  end
end
