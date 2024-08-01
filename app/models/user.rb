class User < ApplicationRecord
  include Roles

  ACTIVE = "active".freeze
  BLOCK  = "blocked".freeze
  STATUS = [ACTIVE, BLOCK].freeze
  
  has_secure_password

  has_many                :bookings, dependent:  :destroy
  has_many                :payments, dependent:  :destroy
  has_many                :user_roles
  has_many                :tickets, through:    :bookings
  has_many                :roles,   through:    :user_roles
  has_many                :messages, class_name: "Message", foreign_key: "sender_id"
  # has_and_belongs_to_many :roles, join_table: :user_roles

  GENDER = %w[male female other].freeze
  
  validates :email, :user_name, :gender, presence: true
  
  validates :email,     uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :user_name, uniqueness: true
  validates :gender,    inclusion:  {in: GENDER}
  validates :password,  length:     {minimun: 6, maximum: 72}

  after_save do
    user_roles.create(role: Role.find_by_name(Role::MEMBER)) if roles.empty?
  end

  STATUS.each do |status|
    scope_name = "#{status}_users".to_sym
    scope scope_name, -> { where(account_status: status) }
  end
  
end
