class Account < ActiveRecord::Base
	 self.abstract_class = true

  # Open a connection to the appropriate database depending
  # on what RAILS_ENV is set to.
  establish_connection("factory_#{Rails.env}")
  
end
class Mfg_capacity < Account
end
