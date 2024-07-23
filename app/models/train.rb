class Train < ApplicationRecord

  CATEGORY      = %w[local express superfast].freeze
  WORKING_DAYS  = %w[Mon Tue Wed Thr Fri Sat Sun].freeze
  
  has_many :schedules, dependent: :destroy
  
  validates :name,                   length: {minimum: 8, maximum: 50}, uniqueness: true
  validates :working_days, :coaches, presence: true
  validates :category,               inclusion: {in: CATEGORY}

  validate :check_name_characters
  
  scope :order_by_routes_count, -> {
    joins(:schedules)
      .select('trains.*, COUNT(schedules.id) AS routes_count')
      .group('trains.id')
      .order('routes_count DESC')
  }
  
  scope :total_class_seats, -> (train, slug) {
    Coach.joins(:seats)
          # .where(id: train.coaches, slug_name: slug)
          .where(id: train.coaches, tier: slug)
          .count
  }
  
  private
  
  def check_name_characters
    errors.add(:name, "should contains only alphabetical characters") unless (name&.match?(/\A[a-zA-Z\s]*\z/)) 
  end
  
end
