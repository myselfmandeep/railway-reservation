class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :role

  validate :has_role

  private

  def has_role
    errors.add(:base, "User already has role #{role.name}") if user.roles.include?(role)
  end
end