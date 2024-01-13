require 'rails_helper'

RSpec.describe Entity, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      user = User.create(name: 'Test User', email: 'user@example.com', password: 'password')
      entity = Entity.new(name: 'Test Entity', amount: 100, user:)
      expect(entity).to be_valid
    end

    it 'is not valid without a name' do
      user = User.create(name: 'Test User', email: 'user@example.com', password: 'password')
      entity = Entity.new(name: nil, amount: 100, user:)
      expect(entity).not_to be_valid
    end

    it 'is not valid with a negative amount' do
      user = User.create(name: 'Test User', email: 'user@example.com', password: 'password')
      entity = Entity.new(name: 'Test Entity', amount: -10, user:)
      expect(entity).not_to be_valid
    end
  end

  context 'scopes' do
    it 'returns entities in most recent order' do
      user = User.create(name: 'Test User', email: 'user@example.com', password: 'password')
      entities = [
        Entity.create(name: 'Entity 1', amount: 50, user:, created_at: 3.days.ago),
        Entity.create(name: 'Entity 2', amount: 75, user:, created_at: 2.days.ago),
        Entity.create(name: 'Entity 3', amount: 100, user:, created_at: 1.day.ago)
      ]

      result = Entity.most_recent(user)

      expect(result).to eq([entities[2], entities[1], entities[0]])
    end
  end
end
