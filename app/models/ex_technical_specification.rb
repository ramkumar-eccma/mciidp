require 'safe_attributes/base'
class Accountex< ActiveRecord::Base
  # No corresponding table in the DB.
  self.abstract_class = true

  # Open a connection to the appropriate database depending
  # on what RAILS_ENV is set to.
  establish_connection("ex_#{Rails.env}")
end
class ExTechnicalSpecification < Accountex
		include SafeAttributes::Base
end
