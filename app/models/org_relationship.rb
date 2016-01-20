class Account < ActiveRecord::Base
	# No corresponding table in the DB.
  self.abstract_class = true

  # Open a connection to the appropriate database depending
  # on what RAILS_ENV is set to.
  establish_connection("factory_#{Rails.env}")
  
end
class Org_relationship < Account
end
