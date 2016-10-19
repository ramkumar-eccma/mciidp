require 'safe_attributes/base'
class AccountBase < ActiveRecord::Base
  # No corresponding table in the DB.
  self.abstract_class = true

  # Open a connection to the appropriate database depending
  # on what RAILS_ENV is set to.
  establish_connection("ksa_#{Rails.env}")
end
class Classification < AccountBase
	include SafeAttributes::Base
	has_many :TechnicalSpecification, foreign_key: "cat_id"
	has_many :RxmlReference, foreign_key: "cat_id" 
end
