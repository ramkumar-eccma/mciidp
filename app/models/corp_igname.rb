require 'safe_attributes/base'
class  AccountBase < ActiveRecord::Base

	 self.abstract_class = true
  establish_connection ("ksa_#{Rails.env}")
  
end

class CorpIgname < AccountBase
	include SafeAttributes::Base
end
