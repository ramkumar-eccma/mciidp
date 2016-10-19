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
    @a=Image.find_by_id(params[:cat_id])
  #  @b=@a.file_content
  #  @data=@image.file_content
 #	send_data @a.file_content,:type => "image/jpg", :disposition => :inline
     @len=Setting.where("organization_ID=123")

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

    length_sd=params[:len_sd].to_i
    length_ld=params[:len_ld].to_i
    @v=params[:task].reject(&:blank?)
    @class=params[:class]
    @v1=params[:task]
    @prop=params[:ids_to_update1]
    @d=length_sd
    @e=length_ld

    results=ActiveRecord::Base.connection.execute("select * from `made_in_ksa`.settings")
    results.each(:as => :hash) do |res|
    @z=res["class_prop_sep_SD"]
    @y=res["prop_value_sep_LD"]
    @x=res["class_prop_sep_LD"]
    @sh_case=res["short_desc_case"]
    @lg_case=res["long_desc_case"]
    @val_case=res["value_case"]
    @len_ld=res["length_LD"]

  @id=params[:cat_id]

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

      if @val_case=='Lower Case'
    @cs=@cs.downcase
    @dc=@ds.downcase
    @es=@es.downcase
  elsif @val_case=='Sentence Case'
     @cs=@cs.capitalize
    @dc=@ds.capitalize
    @es=@es.capitalize
  else
     @cs=@cs.upcase
    @dc=@ds.upcase
    @es=@es.upcase
  end

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
      if @val_case=='Lower Case'
    @ct=@ct.downcase
    @dt=@dt.downcase
    @et=@et.downcase
  elsif @val_case=='Sentence Case'
     @ct=@ct.capitalize
    @dt=@dt.capitalize
    @et=@et.capitalize
  else
     @ct=@ct.upcase
    @dt=@dt.upcase
    @et=@et.upcase
  end

      @update1=RxmlReference.where('Seq = ? AND property = ? AND cat_id =?',@et,@dt,@id).update_all(value: @ct)

    end

 
# @v=params[:task].reject(&:blank?).join(",")
#   @class=params[:class]
#@v1=params[:task]
# @prop=params[:ids_to_update1]
# @b=@prop.zip(@v1).delete_if { |x| x[1] == "" }.collect{|y| y[0]+':'+y[1]+','}.join('')
#@update2=Classification.where('cat_id = ?',@id).update_all({short_description: @class+','+@v,long_description: @class+','+@b,lastmodified: Time.now})
@bs=@class 
@b=@prop.zip(@v1).delete_if{ |x| x[1]==""}.collect{|y| y[0]+@y+y[1]}
  @b.each do |s|
     @v.each do |a|
         @bs1=@bs+@z+a
      if @bs1.length<=@d
         @bs=@bs+@z+a
      end       
    end
          @lg=@class+@x+s
      
      if @lg.length>=@e && @len_ld=='0'
          @class=@class+@x+s

      elsif @lg.length<=@e && @len_ld!='0'
          @class=@class+@x+s
      end
  end

end


  if @sh_case=='Lower Case'
    @bs=@bs.downcase
  elsif @sh_case=='Sentence Case'|| @lg_case=='Not Set'
    @bs=@bs.capitalize
  else 
    @bs=@bs.upcase
  end

  if @lg_case=='Lower Case'
    @class=@class.downcase
  elsif @lg_case=='Sentence Case'|| @lg_case=='Not Set'
    @class=@class.capitalize
  else
    @class=@class.upcase
end
    @update1=Classification.where('cat_id = ?',@id).update_all({short_description: @bs,long_description: @class}) 

end
   redirect_to controller: 'madein_ksa',action: 'view', cat_id: @id
end



def add_material
  @a=(Classification.maximum("cmm_material_no"))+1
  @class_sel=Classification.select("cat_id").where("cmm_material_no = ?")
end

def settings
      @len=Setting.where("organization_ID=123")
      @length_sd=params[:length_sd]
      @length_ld=params[:length_ld]    
      @class_prop_sep_SD=params[:class_prop_sep_SD]  
      @class_prop_sep_LD=params[:class_prop_sep_LD]
      @prop_val_sep_SD=params[:prop_val_sep_SD]
      @prop_val_sep_LD=params[:prop_val_sep_LD]
      @char_sep_SD=params[:charac_sep_SD]
      @char_sep_LD=params[:charac_sep_LD]
      @case_SD=params[:sh_case]
      @case_LD=params[:lg_case]
      @case_val=params[:Val_case]
      @settings=Setting.where("organization_ID=123")
      if @length_ld
        @settings=Setting.where("organization_ID=123").update_all({length_SD: @length_sd,length_LD: @length_ld,
          class_prop_sep_SD: @class_prop_sep_SD,class_prop_sep_LD: @class_prop_sep_LD,prop_value_sep_SD: @prop_val_sep_SD,
          prop_value_sep_LD: @prop_val_sep_LD,charac_sep_SD: @char_sep_SD,charac_sep_LD: @char_sep_LD,short_desc_case: @case_SD,long_desc_case: @case_LD,value_case: @case_val})  
      end
end

end


