# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

  # users = %w[arpit bablu chandu dinesh eka frog gamer hive inder joker kite lion mango nest orange parrot queen racer stadium train umbrella van wife x-man yolk zebra].each do |name|
  #   # User.create(name: name, email: "#{name}@gmail.com", password_digest: 123456, user_name: "user_#{name}", gender: User::GENDER.sample, reset_token: SecureRandom.urlsafe_base64) 
  #   p User.find_by_email("#{name}@gmail.com").destroy
  # end


  # stations= ["Ambala Cantt", "Chandigarh Juction", "SAS Nagar Mohali", "New Morinda Juction", "Samrala", "Sanhewal", "Ludhiana", "Phagwara Juction", "Jalandhar Cantt", "Jalandhar Juc", "Beas Juction", "Amritsar Juction", "Ferozpur Juction", "Jalalabaad Juction"]

  # stations.each do |name|
  #   Station.create(name: name)
  # end

  # 10.times do |n|
  #   char = Array("a".."z").sample
  #   category = ["2S", "AC", "SL"]

  #   Coach.create(name: "#{char}#{rand(1..100)}", category: category.sample, seat: rand(50...100))

  # end

  # # coaches
  # Coach.all.each do |coach|
  #   unless coach.nil?
  #     108.times do |n|
  #       seat = coach.seats.create(number: n+1, berth: Seat::BERTH.sample, position: Seat::POSITION.sample)
  #       p "added seat: #{seat.number} | berth: #{seat.berth} | position: #{seat.position} to coach: #{coach.name}"
  #     end
  #   end
  # end


=begin
  # tiers
  CLASS = {
    "1AC" => "1 Tier AC",
    "2AC" => "2 Tier AC",
    "3AC" => "3 Tier AC",
    "EV"  => "Vistadome AC",
    "EA"  => "Anubhuti Class",
    "EC"  => "Executive Chair",
    "FC"  => "First Class",
    "3E"  => "3 AC Economy",
    "CC"  => "AC Chair Car",
    "SL"  => "Sleeper",
    "2S"  => "Second Sitting"
  }.freeze

  PRICES = {
    "1AC" => 5,
    "2AC" => 4,
    "3AC" => 3,
    "EV"  => 2.5,
    "EA"  => 2.1,
    "EC"  => 1.7,
    "FC"  => 1.65,
    "3E"  => 1.2,
    "CC"  => 1.25,
    "SL"  => 0.90,
    "2S"  => 0.75
  }.freeze
  
  
  CLASS.each do |k,v|
    Tier.create(name: v, short_form: k, price_per_km: PRICES[k])
  end
  
=end