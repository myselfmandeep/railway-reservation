class Train < ApplicationRecord

  CATEGORY      = %w[local express superfast].freeze
  WORKING_DAYS  = %w[Mon Tue Wed Thr Fri Sat Sun].freeze
  WDAY_F_NAME   = HashWithIndifferentAccess.new({mon: "monday", tue: "tuesday", wed: "wednesday", thr: "thursday", fri: "friday", sat: "saturday", sun: "sunday"})

  has_many :schedules, dependent: :destroy
  
  validates :name,                   length: {minimum: 8, maximum: 50}, uniqueness: true
  validates :working_days, :coaches, presence: true
  validates :category,               inclusion: {in: CATEGORY}

  validate :check_name_characters
  
  before_save -> {
    self.uniq_number = get_random_number(5)
  }
  
  scope :order_by_routes_count, -> {
    joins(:schedules)
      .select('trains.*, COUNT(schedules.id) AS routes_count')
      .group('trains.id')
      .order('routes_count DESC')
  }
  
  scope :total_class_seats, -> (train, slug) {
    Coach.joins(:seats)
          .where(id: train.coaches, tier: slug)
          .count
  }

  WORKING_DAYS.each do |day|
    scope "runs_on_#{WDAY_F_NAME[day.downcase]}".to_sym, -> { where("? = ANY(working_days)", day) }
  end
  
  def coaches
    Coach.where(id: attributes["coaches"])
  end
  
  private
  
  def check_name_characters
    errors.add(:name, "should contains only alphabetical characters") unless (name&.match?(/\A[a-zA-Z\s]*\z/)) 
  end
  
end
