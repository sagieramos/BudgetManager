class Entity < ApplicationRecord
  include ActiveModel::Validations
  belongs_to :user, class_name: 'User', foreign_key: :author_id
  # has_and_belongs_to_many :groups
  has_many :group_entities, dependent: :destroy
  has_many :groups, through: :group_entities

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.most_recent(user, limit = 5)
    where(user:).order(created_at: :desc).limit(limit)
  end

  def self.most_ancient(user, limit = 5)
    where(user:).order(created_at: :asc).limit(limit)
  end
end
