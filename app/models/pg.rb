class Pg < ApplicationRecord
  self.table_name = "users"
  
  def self.execute
    str = <<-SQL
      /*
        SELECT u.name mera_naam, u.email meri_email FROM users AS u;
        SELECT u.name || ' ' || u.email FROM users AS u;
        SELECT u.name, u.email FROM users AS u
        ORDER BY u.name ASC,
                 u.email DESC;

        SELECT u.email, LENGTH(u.email) AS len FROM users AS u
        ORDER BY len DESC;

        INSERT INTO users (name, email, created_at, updated_at)
        VALUES ('agel', 'agel@gmail.com', NOW(), NOW());
        # SELECT  DISTINCT u.name FROM users AS u
        # WHERE u.name LIKE '%man%';
        SELECT u.name, u.email FROM users AS u
        WHERE u.name LIKE '%a%'
        LIMIT 5
        OFFSET 5;
        SELECT u.id AS user_id, u.name, b.id AS booking_id, b.date FROM users AS u
        INNER JOIN bookings AS b ON u.id = b.user_id;  

        SELECT users.* FROM users
        ORDER BY users.id ASC
        LIMIT 1
        SELECT roles.* FROM roles 
        INNER JOIN user_roles ON roles.id = user_roles.id
        WHERE user_roles.id = users.id;
        # SELECT * FROM users
        # where name = $1 [["name", "mandeep singh"]];

        SELECT * FROM users   
        INNER JOIN    bookings   ON users.id    = b.user_id
        INNER JOIN    tickets    ON bookings.id = tik.booking_id
        INNER JOIN    seats      ON seats.id    = tickets.seat_id
        INNER JOIN    coaches    ON coaches.id  = seats.coach_id;


      */
      SELECT * FROM user_roles;
    SQL
    
    find_by_sql(str)
  end

  class << self
    # def run(const)
    #   a = const.new(name: nil)
    #   a.save
      
    #   a.errors.full_messages
    # end
    def run
      [TrainRoute.find(7), (today+1.day), "SL"]
    end
  end
  
end