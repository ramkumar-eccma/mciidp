class MadeinKsaController < ApplicationController
  def show
  	if(params[:search])
	    @vs = params[:search]
	    @madein_ksa = initialize_grid(Classification,conditions:["(cat_id like ? OR short_description like ? OR long_description like ?)","%#{@vs}%","%#{@vs}%","%#{@vs}%"],:per_page=>10)
  	else  
		@madein_ksa = initialize_grid(Classification,:per_page=>10)
	end
  end

  def view
  	var=request.query_parameters
	@id=var[:cat_id]
	@data=Classification.where("cat_id = ? ",@id)
	@data1=TechnicalSpecification.select("property","value").where("cat_id = ? AND language='en'",@id)
  end
end
