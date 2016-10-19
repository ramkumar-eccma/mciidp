require 'safe_attributes/base'
class AccountDic < ActiveRecord::Base
  # No corresponding table in the DB.
  self.abstract_class = true

  # Open a connection to the appropriate database depending
  # on what RAILS_ENV is set to.
  establish_connection("eotd_#{Rails.env}")
end
class Term_dn < AccountDic
	include SafeAttributes::Base
	    self.table_name = 'concept_dn'
	
end

# class Definition < AccountDic
# 	include SafeAttributes::Base
# 	    self.table_name = 'definition_dn'
# end

# class Concept_dn < AccountDic
# 	include SafeAttributes::Base
# 	    self.table_name = 'concept_dn'
# end


# require 'safe_attributes/base'
# class AccountDic < ActiveRecord::Base
#   # No corresponding table in the DB.
#   self.abstract_class = true

#   # Open a connection to the appropriate database depending
#   # on what RAILS_ENV is set to.
#   establish_connection("eotd_#{Rails.env}")
# end
# class Term_dn < AccountDic
# 	include SafeAttributes::Base
# 	    self.table_name = 'term_dn'
	
# end

# class Definition < AccountDic
# 	include SafeAttributes::Base
# 	    self.table_name = 'definition_dn'
# end

# class Concept_dn < AccountDic
# 	include SafeAttributes::Base
# 	    self.table_name = 'concept_dn'
# end
