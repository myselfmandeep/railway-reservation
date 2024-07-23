class Role < ApplicationRecord

  ADMIN  = "admin".freeze
  MEMBER = "member".freeze
  ROLES  = [ADMIN, MEMBER].freeze
  
  has_many :users, through: :user_roles
  # has_and_belongs_to_many :users, join_table: :user_roles

  validates :name, inclusion: {in: ROLES}, uniqueness: true, presence: true
  validates :name, inclusion: {in: ROLES}

end