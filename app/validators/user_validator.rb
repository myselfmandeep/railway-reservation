# class UserValidator < ActiveModel::Validator
#   def validate(record)
#     r = record
#     err = r.errors
#     case true
#     when r.name.empty?
#       err.add :name, "should not be empty"
#     when r.email.empty?
#       err.add :email, "should not be empty"
#     when !User::GENDER.include?(r.gender)
#       err.add :gender, "is not a valid gender"
#     when !!User.find_by(user_name: r.user_name)
#       err.add :user_name, "must be unique"
#     end
#   end
# end