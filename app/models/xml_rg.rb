require 'safe_attributes/base'
class  AccountBase < ActiveRecord::Base

	 self.abstract_class = true
  establish_connection ("ksa_#{Rails.env}")
  
end

class XmlRg < AccountBase
	include SafeAttributes::Base
	  self.table_name = 'xml_rg'
end
