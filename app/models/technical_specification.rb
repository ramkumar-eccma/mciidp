require 'safe_attributes/base'
class AccountBase< ActiveRecord::Base
	  self.abstract_class = true
  establish_connection("ksa_#{Rails.env}")
end
class TechnicalSpecification < AccountBase
		include SafeAttributes::Base
		belongs_to :Classification, foreign_key: "cat_id"
end
