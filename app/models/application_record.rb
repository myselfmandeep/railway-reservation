class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def get_object_errors
    errors.full_messages
  end
  
end
