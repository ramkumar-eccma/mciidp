require 'wice_grid'

class MadeinKsaController < ApplicationController
	def show
  lan= I18n.locale
  vars = request.query_parameters
  @type = vars['TYPE']
  if @type =='AVAIL'
		if params[:search]
  		    @vs = params[:search]
  		    @madein_ksa = initialize_grid(Classification,conditions:["(cat_id like ? OR short_description like ? OR long_description like ?)","%#{@vs}%","%#{@vs}%","%#{@vs}%"],:per_page=>10)
  		else  
		@madein_ksa = initialize_grid(Classification,:per_page=>10)
		end
		  else
        if params[:search]
          @vs = params[:search]
          @madein_ksa = initialize_grid(Classification ,conditions:["(cat_id like ? OR short_description like ? OR long_description like ?) ","%#{@vs}%","%#{@vs}%","%#{@vs}%"], :per_page => 10)
        else
         @madein_ksa = initialize_grid(Classification,:per_page=>10)   
        end
    end
end

	def view
		var=request.query_parameters
		@id=var[:cat_id]
		@data=Classification.where("cat_id = ? ",@id)
		@data1=TechnicalSpecification.select("property","value","Seq").where("cat_id = ? ",@id)
		@data2=RxmlReference.select("property","value","Seq").where("cat_id = ?",@id)
   
   
#	@image = Image.where("cat_id = ?",@id).find_by_id("file_content")
   #@a=Image.find_by_id(params[:cat_id])
  #  @b=@a.file_content
  #  @data=@image.file_content
 #send_data @a.file_content,:type => 'image/jpg',:disposition => 'inline'
    @a = Image.find_by_id(params[:cat_id])
    send_data @a.file_content, :type => 'image/jpg',:disposition => 'inline'
	end



	def image_params
	@id=params[:cat_id]
  @id1=params[:pictureInput]
   if @id1
    @pictureInput=params[:pictureInput].read
    if @pictureInput.size
    @sql=Image.where("cat_id = ?",@id).update_all(file_content: @pictureInput)
    end
else
 a=params[:ids_to_update]
     b=params[:task]
     c=params[:ids_to_update1]
    @as=''
    @bs=[]
    @cs=''
  # @ss=[]
   # @s1=params[:task1].zip(params[:cat_id],params[:mat_id])
     @bs=params[:task].zip(params[:ids_to_update1],params[:ids_to_update])

    @bs.each do |a,b,c|
      @cs=a
      @ds=b
      @es=c
      @update=TechnicalSpecification.where('Seq = ? AND property = ? AND cat_id = ? ',@es,@ds,@id).update_all(value: @cs)
    end

    @at=''
    @bt=[]
    @ct=''
    @bt=params[:task1].zip(params[:prop],params[:seq_id])
    @bt.each do |a,b,c|
      @ct=a
      @dt=b
      @et=c
      @update1=RxmlReference.where('Seq = ? AND property = ? AND cat_id =?',@et,@dt,@id).update_all(value: @ct)
    end

 
# @v=params[:task].reject(&:blank?).join(",")
#   @class=params[:class]
#    @v1=params[:task]
# @prop=params[:ids_to_update1]
# @b=@prop.zip(@v1).delete_if { |x| x[1] == "" }.collect{|y| y[0]+':'+y[1]+','}.join('')
#@update2=Classification.where('cat_id = ?',@id).update_all({short_description: @class+','+@v,long_description: @class+','+@b,lastmodified: Time.now})

end
   redirect_to controller: 'madein_ksa',action: 'view', cat_id: @id
  end

  def add_material

    @a=(Classification.maximum("cmm_material_no"))+1
  #  @class_sel=Classification.select("cat_id").where("cmm_material_no = ?")
  end
def image
  var=request.query_parameters
    @id=var[:id]
 @a=Image.find_by_id(@id)
#@b=@a.to_sql
  send_data @a.file_content,:type => 'image/jpg',:disposition => 'inline'



end

end


