require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(name: 'Test User', email: 'user@example.com', password: 'password')
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = User.new(name: nil, email: 'user@example.com', password: 'password')
      expect(user).not_to be_valid
    end

    it 'is not valid without an email' do
      user = User.new(name: 'Test User', email: nil, password: 'password')
      expect(user).not_to be_valid
    end

    it 'is not valid without a password' do
      user = User.new(name: 'Test User', email: 'user@example.com', password: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid with a short password' do
      user = User.new(name: 'Test User', email: 'user@example.com', password: 'pass')
      expect(user).not_to be_valid
    end
  end

  context 'associations' do
    it 'has many entities' do
      user = User.new(name: 'Test User', email: 'user@example.com', password: 'password')
      expect(user).to respond_to(:entities)
    end

    it 'has many groups' do
      user = User.new(name: 'Test User', email: 'user@example.com', password: 'password')
      expect(user).to respond_to(:groups)
    end
  end

  context 'callbacks' do
    it 'deletes associated group entities before destroy' do
      user = User.create(name: 'Test User', email: 'user@example.com', password: 'password')
      group = Group.create(name: 'Test Group', user:)
      Entity.create(name: 'Test Entity', amount: 100, user:, groups: [group])

      expect { user.destroy }.to change { GroupEntity.count }.from(1).to(0)
    end
  end
end
