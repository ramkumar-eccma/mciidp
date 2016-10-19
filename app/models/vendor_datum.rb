# class VendorDatum < ActiveRecord::Base
# end
require 'safe_attributes/base'
class  AccountBase < ActiveRecord::Base

	 self.abstract_class = true
  establish_connection ("ksa_#{Rails.env}")
  
end

class VendorDatum < AccountBase
	include SafeAttributes::Base
	  self.table_name = 'vendor_data'
end
