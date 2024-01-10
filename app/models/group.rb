class Group < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :user, class_name: 'User', foreign_key: :user_id
  has_many :group_entities, dependent: :destroy
  has_many :entities, through: :group_entities

  validates :name, presence: true
  validates :icon, presence: true, format: {
    with: /\.(png|gif|jpeg|jpg|svg)\z/i,
    message: 'Field only accepts png, gif, jpeg, jpg, or svg.'
  }
  validate :valid_local_path_for_icon

  before_validation :set_default_icon

  def self.descending_order_for_user(user)
    where(user:).order(created_at: :desc)
  end

  private

  def valid_local_path_for_icon
    return if icon.blank? ||
              URI.parse(icon).is_a?(URI::HTTP) ||
              (File.exist?(Rails.root.join('app', 'assets', 'images', icon)) if icon.present?)

    errors.add(:icon, 'must be a valid URL or a local file path')
  rescue URI::InvalidURIError
    errors.add(:icon, 'must be a valid URL or a local file path')
  end

  def set_default_icon
    self.icon ||= 'default.png'
  end
end
