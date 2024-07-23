class BookingPolicy < ApplicationPolicy

  def list
    return scope      if is_admin?
    
    return user_scope if is_member?
    
    []
  end

  def scope
    Booking.includes(:user)
  end
  
  def user_scope
    scope.where(user: user) 
  end
  
end