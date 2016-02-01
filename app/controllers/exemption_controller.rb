class ExemptionController < ApplicationController
	def show
		 
		if(params[:search])
  		    @vs = params[:search]
  		    @exemption = initialize_grid(Ex_classification,conditions:["(cat_id like ?  OR short_description like ?  OR long_description like ?)","%#{@vs}%","%#{@vs}%","%#{@vs}%"],:per_page=>10)
  		     @exemptioncount=Ex_classification.where("(cat_id like ?  OR short_description like ?  OR long_description like ?)","%#{@vs}%","%#{@vs}%","%#{@vs}%").count
  	else  
		@exemption = initialize_grid(Ex_classification,:per_page=>10)
		@exemptioncount=Ex_classification.count(:cat_id)
	end
end

	def view
		var=request.query_parameters
		@id=var[:cat_id]
		@data=Ex_classification.where("cat_id = ?",@id)
		@data1=ExTechnicalSpecification.select("property","value").where("cat_id = ?",@id)
	end
	
end
