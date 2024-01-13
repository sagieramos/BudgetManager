require 'rails_helper'

RSpec.describe Group, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      user = User.create(name: 'Test User', email: 'user@example.com', password: 'password')
      group = Group.new(name: 'Test Group', user: user)
      expect(group).to be_valid
    end

    it 'is not valid without a name' do
      user = User.create(name: 'Test User', email: 'user@example.com', password: 'password')
      group = Group.new(name: nil, user: user)
      expect(group).not_to be_valid
    end

    it 'is not valid with a duplicate name for the same user' do
      user = User.create(name: 'Test User', email: 'user@example.com', password: 'password')
      Group.create(name: 'Test Group', user: user)
      group = Group.new(name: 'Test Group', user: user)
      expect(group).not_to be_valid
    end
  end

  context 'custom validations' do
    it 'is not valid with an invalid icon format' do
      user = User.create(name: 'Test User', email: 'user@example.com', password: 'password')
      group = Group.new(name: 'Test Group', user: user)
      group.icon.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'invalid_icon.txt')), filename: 'invalid_icon.txt')
      expect(group).not_to be_valid
    end
  end

  context 'callbacks' do
    it 'sets a default icon before validation' do
      user = User.create(name: 'Test User', email: 'user@example.com', password: 'password')
      group = Group.new(name: 'Test Group', user: user)
      group.valid?
      expect(group.icon.filename).to eq(nil)
    end
  end

  context 'scopes' do
    it 'returns groups in descending order for a user' do
      user = User.create(name: 'Test User', email: 'user@example.com', password: 'password')
      groups = [
        Group.create(name: 'Group 1', user: user, created_at: 3.days.ago),
        Group.create(name: 'Group 2', user: user, created_at: 2.days.ago),
        Group.create(name: 'Group 3', user: user, created_at: 1.day.ago)
      ]

      result = Group.descending_order_for_user(user)

      expect(result).to eq([groups[2], groups[1], groups[0]])
    end
  end
end
