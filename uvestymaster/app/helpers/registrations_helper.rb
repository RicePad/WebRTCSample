module RegistrationsHelper
def checked(area)
  @user.expertise.nil? ? false : @user.expertise.match(area)
end
end
