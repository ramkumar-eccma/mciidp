require 'safe_attributes/base'
class AccountBase < ActiveRecord::Base
	  # No corresponding table in the DB.
  self.abstract_class = true

  # Open a connection to the appropriate database depending
  # on what RAILS_ENV is set to.
  establish_connection("ksa_#{Rails.env}")
end
class RxmlReference < AccountBase
	include SafeAttributes::Base
	belongs_to :Classification, foreign_key: "cat_id"
end
