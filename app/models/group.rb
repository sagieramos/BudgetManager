class Group < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: :user_id
  has_many :group_entities, dependent: :destroy
  has_many :entities, through: :group_entities

  has_one_attached :icon

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validate :valid_icon_format

  before_validation :set_default_icon

  def self.descending_order_for_user(user)
    where(user:).order(created_at: :desc)
  end

  private

  def valid_icon_format
    return unless icon.attached? && icon.blob.present?

    allowed_formats = %w[image/png image/gif image/jpeg image/jpg image/svg+xml]
    return if allowed_formats.include?(icon.blob.content_type)

    errors.add(:icon, 'Field only accepts png, gif, jpeg, jpg, or svg.')
  end

  def set_default_icon
    self.icon ||= 'default.png'
  end
end
