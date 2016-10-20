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
            @madeinksacount = initialize_grid(Classification,conditions:["(cat_id like ? OR short_description like ? OR long_description like ?)","%#{@vs}%","%#{@vs}%","%#{@vs}%"],:per_page=>10).count
      else  
    @madein_ksa = initialize_grid(Classification,:per_page=>10)
    @madeinksacount = initialize_grid(Classification,:per_page=>10).count
    end
      else
        if params[:search]
          @vs = params[:search]
          @madein_ksa = initialize_grid(Classification ,conditions:["(cat_id like ? OR short_description like ? OR long_description like ?) ","%#{@vs}%","%#{@vs}%","%#{@vs}%"], :per_page => 10)
           @madeinksacount = initialize_grid(Classification ,conditions:["(cat_id like ? OR short_description like ? OR long_description like ?) ","%#{@vs}%","%#{@vs}%","%#{@vs}%"], :per_page => 10).count
        else
         @madein_ksa = initialize_grid(Classification,:per_page=>10)  
         @madeinksacount = initialize_grid(Classification,:per_page=>10).count 
        end
    end
end

def view
    lan= I18n.locale
    var=request.query_parameters
    @id=var[:cat_id]
    @data=Classification.where("cat_id = ? ",@id)
    @data1=TechnicalSpecification.select("property","value","Seq","propertyRef","Class","source","name","datecreated").order(:Seq).where("cat_id = ? ",@id)
    @data2=RxmlReference.select("property","value","Seq","value2").where("cat_id = ?",@id)
    @data3=RxmlReference.select("cat_id,property","value","Seq","value2","datadeleted").where("cat_id = ? AND property = ?",@id,'SUPPLIER REFERENCE')
    @data4=RxmlReference.where("cat_id = ? AND property = ?",@id,'SUPPLIER REFERENCE').count("Seq")
    # @image = Image.where("cat_id = ?",@id).find_by_id("file_content")
    #@image=Image.find_by_id(params[:cat_id])
    @image=Image.where("cat_id = ?",@id)
    # @image=Image.find_by_id(params[:cat_id])

    #     if(@image.nil?)
    #       @img='noimage'
    #     else
    #       @img='image'
    #     end
    @len=Setting.where("organization_ID=123")
    @a=(Classification.maximum("cmm_material_no"))+1
    # @class_sel=CorpIgname.select("Class_Name","igref","Class_id")
    @class_sel=CorpIgname.find_by_sql(["SELECT * FROM corp_ignames"])
    @vendor=MmFactory.where(["`Last Status` = ? AND  Language = ?",'OPERATIONAL',lan])
    @id=params[:cat_id]
    @class=params[:class]
    @class_name=params[:txt_class]
    @cmm=params[:cmm]
    @id1=params[:pictureInput]
    if @id1 
    # @pictureInput=params[:pictureInput].read
    # if @pictureInput.size
    # @sql=Image.where("cat_id = ?",@id).update_all(file_content: @pictureInput)
    # end
    @name=@id1.original_filename.gsub("-","_")
    n1=@id+"_"+@name
    n2=@id+"_"+params[:pictureInput].original_filename.gsub("-","_").to_s
    @sql=Image.where("cat_id = ?",@id).update_all(image_name: n1)
    tmp=params[:pictureInput].tempfile
    destiny_file = File.join('app','assets','ksa_image',n2)
    FileUtils.move tmp.path, destiny_file
end

if @class_name || @class
#@setting=Setting.where("organization_ID=123")
length_sd=params[:len_sd].to_i
length_ld=params[:len_ld].to_i
#@v=params[:task].reject(&:blank?)
@class=params[:class]
@v1=params[:task]
@prop=params[:ids_to_update1]
@d=length_sd
@e=length_ld
@ss=':'

                    @class_name=params[:txt_class]
                    @material_id=params[:material_id]
                    @supplier_no=params[:supplier_id]
                    @property=params[:task]
                    @value=params[:task1]
                    @propref=params[:task2]
                    @row=params[:task3]

                    @mfr=params[:mfr]
                    @mfr1=params[:mfr1]
                    @mfr_partno=params[:mfr_partno]
                    @mfr_task4=params[:mfr_task4]
                    @mfr_url=params[:mfr_url]
                    @supp=params[:supp]
                    @supp1=params[:supp1]
                    @supp_partno=params[:supp_partno]
                    @supp_url=params[:supp_url]
                    @supp_task4=params[:supp_task4]
                    @unspsc=params[:unspsc]
                    @unspsc1=params[:unspsc1]
                    @unspsc2=params[:unspsc2]
                    @unspsc3=params[:unspsc3]
                    @unspsc_task4=params[:unspsc_task4]
                    @bu_other=params[:bu]
                    @bu_value=params[:bu1]
                    @bu_value1=params[:bu2]
                    @other_task4=params[:other_task4]
                    @igref=params[:txt_igid]
                    @class_id=params[:txt_classid]
                    @bu3=params[:bu3]
                    @bu4=params[:bu4]
                    @other_task5=params[:other_task5]

                    @new_prop=params[:new_prop]
                    @new_value=params[:new_value]
                    @new_propref=params[:new_propref]
                    @new_row=params[:new_row]
                    @new_igid=params[:new_igid]
                    @new_class=params[:new_class1]

                     @new_supp=params[:supp_id2]
                    @new_supp_partno=params[:supp_new_partno]
                    @new_supp_url=params[:supp_new_url]
                    @new_supp_value=params[:supp1_new]

                        results=ActiveRecord::Base.connection.execute("select * from `made_in_ksa`.settings")
                        results.each(:as => :hash) do |res|
                        @z=res["class_prop_sep_SD"]
                        @y=res["prop_value_sep_LD"]
                        @x=res["class_prop_sep_LD"]
                        @sh_case=res["short_desc_case"]
                        @lg_case=res["long_desc_case"]
                        @val_case=res["value_case"]
                        @len_ld=res["length_LD"]
                        @len_sd=res["length_SD"]

                          @class_1=params[:txt_class]

                    if @class_name
                        @class_name1=@class_name
                        @bs=@class_name
                          @rg=@igref.gsub("IG","RG")
                           @v=params[:task1].reject(&:blank?)
                            @value=params[:task1]
                           @b=@property.zip(@value).delete_if{ |x| x[1]==""}.collect{|y| y[0]+@y+y[1]}
                           
                             @v.each do |a|
                                 @bs1=@bs+@z+a
                              if @bs1.length <= @len_sd.to_i
                                 @bs=@bs+@z+a
                              end       
                            end
                            @b.each do |s|
                             @lg=@class_1+@x+s
                              if @lg.length>=@len_ld.to_i && @len_ld=='0'
                                  @class_1=@class_1+@x+s

                              elsif @lg.length<=@len_ld.to_i && @len_ld!='0'
                                  @class_1=@class_1+@x+s
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
                            @class_1=@class_1.downcase
                          elsif @lg_case=='Sentence Case'|| @lg_case=='Not Set'
                            @class_1=@class_1.capitalize
                          else
                            @class_1=@class_1.upcase
                        end


                         @sql=Classification.where(cat_id: @cmm).first_or_create(username: 'Eccma-Admin',realname: 'Eccma-Admin',igid: @igref,cat_id: @cmm,catalog_name: @class_name,material_id: @material_id,
                           datecreated: Time.now,datedeleted: '',legacy_description: '',short_description: @bs,long_description: @class_1,RGref: @rg,Class: @class_name,class_id: @class_id,
                           supplier_material_no: @supplier_no,cmm_material_no: @cmm,FACTORY_ID: '',FACTORY_NAME_ECCMA: '',FACTORY_NAME_TESS: '',Flag: '')


                       @val=@property.zip(@value,@propref,@row).each do |a,b,c,d|
                            @x=a
                            @y=b
                            @z=c
                            @s=d
                             if @val_case=='Lower Case'
                            @y1=@y.downcase
                          elsif @val_case=='Sentence Case'
                             @y1=@y.capitalize
                          else
                             @y1=@y.upcase
                          end

                          @sql1=TechnicalSpecification.create(row: @s,Seq: @s,igid: @igref,cat_id: @cmm,Class: @class_name,classref: @class_id,propertyRef: @z,property: @x,value: @y1,datecreated: Time.now,prop_val: '')
                          end

                            @bu=@mfr.zip(@mfr1,@mfr_url,@mfr_partno,@mfr_task4).each do |a,b,c,d,e|
                            @s=a
                            @b=b
                            @c=c
                            @d=d
                            @e=e
                            @y=@b+':'+@d
                            if @val_case=='Lower Case'
                              @y1=@y.downcase
                            elsif @val_case=='Sentence Case'
                              @y1=@y.capitalize
                            else
                              @y1=@y.upcase
                            end
                            @bu=RxmlReference.create(row: @e,Seq: @e,igid: @igref,cat_id: @cmm,Class: @class_name,classref: @class_id,property:@s,value: @y1,value2: @c,datecreated: Time.now,language: '')
                           end

                            @bu1=@supp.zip(@supp1,@supp_url,@supp_partno,@supp_task4).each do |a,b,c,d,e|
                            @s=a
                            @b=b
                            @c=c
                            @d=d
                            @e=e
                              @y=@b+':'+@d
                            if @val_case=='Lower Case'
                              @y1=@y.downcase
                            elsif @val_case=='Sentence Case'
                              @y1=@y.capitalize
                            else
                              @y1=@y.upcase
                            end
                            @bu=RxmlReference.create(row: @e,Seq: @e,igid: @igref,cat_id: @cmm,Class: @class_name,classref: @class_id,property:@s,value: @y1,value2: @c,datecreated: Time.now,language: '')
                          end

                            @bu2=@bu_other.zip(@bu_value,@other_task4).each do |a,b,c|
                            @s=a
                            @b=b
                            @c=c
                            if @val_case=='Lower Case'
                              @y1=@b.downcase
                            elsif @val_case=='Sentence Case'
                              @y1=@b.capitalize
                            else
                              @y1=@b.upcase
                            end                            
                            @bu=RxmlReference.create(row: @c,Seq: @c,igid: @igref,cat_id: @cmm,Class: @class_name,classref: @class_id,property:@s,value: @y1,datecreated: Time.now,language: '')
                            end

                             @y1=@unspsc1+@ss+@unspsc2+@ss+@unspsc3
                                     if @val_case=='Lower Case'
                                    @y1=@y1.downcase
                                  elsif @val_case=='Sentence Case'
                                     @y1=@y1.capitalize
                                  else
                                     @y1=@y1.upcase                  
                                  end                            
                            @bu=RxmlReference.create(row: @unspsc_task4,Seq: @unspsc_task4,igid: @igref,cat_id: @cmm,Class: @class_name,classref: @class_id,property:@unspsc,value: @y1,datecreated: Time.now,language: '')
                          #end
                    redirect_to controller: 'madein_ksa',action: 'view', cat_id: @cmm


                  elsif @new_value
                            @new1=@new_class
                            @rgref=@new_igid.gsub("IG","RG")
                            @bs=@new_class 
                            @new_class_val=params[:new_value].reject(&:blank?)
                            @new_class_prop=@new_prop.zip(@new_value).delete_if{ |x| x[1]==""}.collect{|y| y[0]+@y+y[1]}
                             TechnicalSpecification.where(cat_id: @id).each do |x|
                          TechspecRemoving.create(row: x.row,Seq: x.Seq,igid: x.igid,cat_id: x.cat_id,property: x.property,value: x.value)
                        end
                        @test=TechnicalSpecification.destroy_all(cat_id: @id)
                           
                               @new_class_val.each do |a|
                                   @bs1=@bs+@z+a
                                if @bs1.length<=@len_sd.to_i
                                   @bs=@bs+@z+a
                                end       
                              end
                               @new_class_prop.each do |s|
                                    @lg=@new_class+@x+s
                                if @lg.length>=@len_ld.to_i && @len_ld=='0'
                                    @new_class=@new_class+@x+s

                                elsif @lg.length<=@len_ld.to_i && @len_ld!='0'
                                    @new_class=@new_class+@x+s
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
                              @new_class=@new_class.downcase
                            elsif @lg_case=='Sentence Case'|| @lg_case=='Not Set'
                              @new_class=@new_class.capitalize
                            else
                              @new_class=@new_class.upcase
                          end
                              @update1=Classification.where('cat_id = ?',@id).update_all({igid: @new_igid,catalog_name: @new1,Class: @new1,short_description: @bs,long_description: @new_class,RGref: @rgref,lastmodified: Time.now}) 

                              @val=@new_prop.zip(@new_value,@new_propref,@new_row).each do |a,b,c,d|
                            @x=a
                            @y=b
                            @z=c
                            @s=d
                        
                             if @val_case=='Lower Case'
                             @y=@y.downcase
                          elsif @val_case=='Sentence Case'
                             @y=@y.capitalize
                          else
                             @y=@y.upcase
                          end
                      @insert=TechnicalSpecification.create(row: @s,Seq: @s,igid: @new_igid,cat_id: @id,Class: @new1,property: @x,value: @y,propertyRef: @z,prop_val: '',datecreated: Time.now)
                       end
                       
                        redirect_to controller: 'madein_ksa',action: 'view',cat_id: @id

                    else
                          @class=params[:class]
                            @bs=@class 
                            @v=params[:task].reject(&:blank?)

                          @b=@prop.zip(@v1).delete_if{ |x| x[1]==""}.collect{|y| y[0]+@y+y[1]}
                            @b.each do |s|
                               @v.each do |a|
                                   @bs1=@bs+@z+a
                                if @bs1.length<=@len_sd.to_i
                                   @bs=@bs+@z+a
                                end       
                              end
                                    @lg=@class+@x+s
                                if @lg.length>=@len_ld.to_i && @len_ld=='0'
                                    @class=@class+@x+s

                                elsif @lg.length<=@len_ld.to_i && @len_ld!='0'
                                    @class=@class+@x+s
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
                              @update1=Classification.where('cat_id = ?',@id).update_all({short_description: @bs,long_description: @class,lastmodified: Time.now}) 

                   

                                 @id=params[:cat_id]

                               @a=params[:ids_to_update]
                                   @b=params[:task]
                                   @c=params[:ids_to_update1]
                                  # @as=''
                                  # @bs=[]
                                  # @cs=''
                                  #  @bs=params[:task].zip(params[:ids_to_update1],params[:ids_to_update])
                                  # @bs.each do |a,b,c|
                                  #   @cs=a
                                  #   @ds=b
                                  #   @es=c
                                    for a,b,c in @b.zip(@c,@a)
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

                                    @update=TechnicalSpecification.where('Seq = ? AND property = ? AND cat_id = ? ',@es,@ds,@id).update_all(value: @cs,lastmodified: Time.now)
                                  end

                                  
                                 # @bu=@mfr.zip(@mfr1,@mfr_url,@mfr_partno,@mfr_task4).each do |a,b,c,d,e|
                                 #    @s=a
                                 #    @b=b
                                 #    @c=c
                                 #    @d=d
                                 #    @e=e
                                    for a,b,c,d,e in @mfr.zip(@mfr1,@mfr_url,@mfr_partno,@mfr_task4)
                                    @s=a
                                    @b=b
                                    @c=c
                                    @d=d
                                    @e=e
                                  if @b!=''&&@d!='' 
                                    @y1=@b+@ss+@d
                                  elsif @b==''&&@d!='' 
                                    @y1='UNKNOWN'+@ss+@d
                                     elsif @b==''&&@d==''
                                     @y1='UNKNOWN'+@ss+'UNKNOWN'
                                  else
                                     @y1=@b+@ss+'UNKNOWN'
                                   end
                                    if @val_case=='Lower Case'
                                    @y2=@y1.downcase
                                  elsif @val_case=='Sentence Case'
                                     @y2=@y1.capitalize
                                  else
                                     @y2=@y1.upcase               
                                  end
                                    @update1=RxmlReference.where('Seq = ? AND property = ? AND cat_id =?',@e,@s,@id).update_all(value: @y2,value2: @c,lastmodified: Time.now)

                                   end

                                    # @bu1=@supp.zip(@supp1,@supp_url,@supp_partno,@supp_task4).each do |a,b,c,d,e|
                                    #   @s=a
                                    # @b=b
                                    # @c=c
                                    # @d=d
                                    # @e=e
                                    for a,b,c,d,e in @supp.zip(@supp1,@supp_url,@supp_partno,@supp_task4)
                                      @s=a
                                    @b=b
                                    @c=c
                                    @d=d
                                    @e=e
                                      if @b!=''&&@d!='' 
                                    @y1=@b+@ss+@d
                                  elsif @b==''&&@d!='' 
                                    @y1='UNKNOWN'+@ss+@d
                                  elsif @b==''&&@d==''
                                     @y1='UNKNOWN'+@ss+'UNKNOWN'
                                    else
                                     @y1=@b+@ss+'UNKNOWN'
                                   end
                                    if @val_case=='Lower Case'
                                    @y2=@y1.downcase
                                  elsif @val_case=='Sentence Case'
                                     @y2=@y1.capitalize
                                  else
                                     @y2=@y1.upcase               
                                  end
                                      @update1=RxmlReference.where('Seq = ? AND property = ? AND cat_id =?',@e,@s,@id).update_all(value: @y2,value2: @c,lastmodified:Time.now)
                                    end

                                     @bu2=@bu_other.zip(@bu_value,@other_task4).each do |a,b,c|
                                      @s=a
                                      @b=b
                                      @c=c
                                      # for a,b,c in @bu_other.zip(@bu_value,@other_task4)
                                      # @s=a
                                      # @b=b
                                      # @c=c
                                     if @val_case=='Lower Case'
                                    @y1=@b.downcase
                                  elsif @val_case=='Sentence Case'
                                     @y1=@b.capitalize
                                  else
                                      @y1=@b.upcase               
                                  end
                                      @update1=RxmlReference.where('Seq = ? AND property = ? AND cat_id =?',@c,@s,@id).update_all(value: @y1,lastmodified:Time.now)
                                    end

                                     @bu8=@bu4.zip(@bu3,@other_task5).each do |a,b,c|
                                      @s=a
                                      @b=b
                                      @c=c
                                     if @val_case=='Lower Case'
                                    @y1=@b.downcase
                                  elsif @val_case=='Sentence Case'
                                     @y1=@b.capitalize
                                  else
                                      @y1=@b.upcase               
                                  end
                                      @update1=RxmlReference.where('Seq = ? AND property = ? AND cat_id =?',@c,@s,@id).update_all(value: @y1,lastmodified:Time.now)
                                    end

                                    @y1=@unspsc1+@ss+@unspsc2+@ss+@unspsc3
                                    if @val_case=='Lower Case'
                                    @y1=@y1.downcase
                                  elsif @val_case=='Sentence Case'
                                     @y1=@y1.capitalize
                                  else
                                     @y1=@y1.upcase               
                                  end
                                      @update1=RxmlReference.where('Seq = ? AND property = ? AND cat_id =?',@unspsc_task4,@unspsc,@id).update_all(value: @y1,lastmodified:Time.now)
                                   # end

                                   if @new_supp 
                                      @supp9=@supp.zip(@new_supp_value,@new_supp_partno,@new_supp_url).each do |a,b,c,d|
                                      @a=a
                                      @b=b
                                      @c=c
                                      @d=d
                                      @x=@b
                                        @bb=RxmlReference.where("cat_id = ?",@id).maximum("row")
                                        @aa=@bb+1.to_s
                                 
                                          @insert1=RxmlReference.create(row: @aa,Seq: @aa,igid: @supp_igid,Class: params[:class],classref: @supp_class_id,cat_id: @id,property: @a,value: @x,value2: @d,datecreated: Time.now,language: '')
                                    end
                                     end
                                      redirect_to controller: 'madein_ksa',action: 'view', cat_id: @id
                                end
                               end
                              end
                            end


def detail_view
    @classname_count=Classification.count(:cat_id)
      #@ksa_battery = Classification.where(["catalog_name= ?", 'BATTERY,STORAGE']).count  find_by_sql(["SELECT count(*) as total FROM `source_data` where country_eccma!='NULL' ORDER BY `CAGEC` DESC"])
      @top1 =Classification.find_by_sql(["SELECT distinct catalog_name,count(*) as total FROM `classifications` where catalog_name!='NULL' group by catalog_name ORDER BY `total` DESC limit 0,1"])
      @top2 =Classification.find_by_sql(["SELECT distinct catalog_name,count(*) as total FROM `classifications` where catalog_name!='NULL' group by catalog_name ORDER BY `total` DESC limit 1,1"])
      @top3 =Classification.find_by_sql(["SELECT distinct catalog_name,count(*) as total FROM `classifications` where catalog_name!='NULL' group by catalog_name ORDER BY `total` DESC limit 2,1"])
       @top4 =Classification.find_by_sql(["SELECT distinct catalog_name,count(*) as total FROM `classifications` where catalog_name!='NULL' group by catalog_name ORDER BY `total` DESC limit 3,1"])
       @topothers =Classification.find_by_sql(["SELECT distinct catalog_name,count(*) as total FROM `classifications` where catalog_name!='NULL' group by catalog_name ORDER BY `total` DESC limit 4,1"])
     
      @top1.each do |a|
       @ksa_top1 = Classification.where(["catalog_name= ?", a.catalog_name]).count
      end
      @top2.each do |b|
       @ksa_top2 = Classification.where(["catalog_name= ?", b.catalog_name]).count
      end
      @top3.each do |c|
       @ksa_top3 = Classification.where(["catalog_name= ?", c.catalog_name]).count
      end
      @top4.each do |d|
       @ksa_top4 = Classification.where(["catalog_name= ?", d.catalog_name]).count
      end

        
        #@ksa_battery=Classification.find_by_sql(["SELECT distinct count(*) as total FROM `classifications` where catalog_name!='NULL' group by catalog_name ORDER BY `total` DESC limit 0,1"])

         # @ksa_wire = Classification.where(["catalog_name= ?", @top2]).count
         # @ksa_bar = Classification.where(["catalog_name= ?", 'PIPE,METALLIC']).count
         # @ksa_panel = Classification.where(["catalog_name= ?", 'BPANEL,CEILING']).count
         # @ksa_cable = Classification.where(["catalog_name= ?", 'CABLE,POWER,ELECTRICAL']).count
         @others=@ksa_top1+@ksa_top2+@ksa_top3+@ksa_top4
         @ksa_others=@classname_count-@others
  
        @top_factory1 =Classification.find_by_sql(["SELECT distinct FACTORY_NAME_ECCMA,FACTORY_ID,count(*) as total FROM `classifications` where FACTORY_NAME_ECCMA!='NULL' group by FACTORY_NAME_ECCMA ORDER BY `total` DESC limit 0,1"])
        @top_factory2 =Classification.find_by_sql(["SELECT distinct FACTORY_NAME_ECCMA,FACTORY_ID,count(*) as total FROM `classifications` where FACTORY_NAME_ECCMA!='NULL' group by FACTORY_NAME_ECCMA ORDER BY `total` DESC limit 1,1"])
        @top_factory3 =Classification.find_by_sql(["SELECT distinct FACTORY_NAME_ECCMA,FACTORY_ID,count(*) as total FROM `classifications` where FACTORY_NAME_ECCMA!='NULL' group by FACTORY_NAME_ECCMA ORDER BY `total` DESC limit 2,1"])
        @top_factory4 =Classification.find_by_sql(["SELECT distinct FACTORY_NAME_ECCMA,FACTORY_ID,count(*) as total FROM `classifications` where FACTORY_NAME_ECCMA!='NULL' group by FACTORY_NAME_ECCMA ORDER BY `total` DESC limit 3,1"])

      @top_factory1.each do |a|
       @ksa_top_factory1 = Classification.where(["FACTORY_ID= ?", a.FACTORY_ID]).count
      end
      @top_factory2.each do |b|
       @ksa_top_factory2 = Classification.where(["FACTORY_ID= ?", b.FACTORY_ID]).count
      end
      @top_factory3.each do |c|
       @ksa_top_factory3 = Classification.where(["FACTORY_ID= ?", c.FACTORY_ID]).count
      end
      @top_factory4.each do |d|
       @ksa_top_factory4 = Classification.where(["FACTORY_ID= ?", d.FACTORY_ID]).count
      end


      # @ksa_factory1=Classification.where(["FACTORY_NAME_ECCMA= ?", 'NATIONAL BATTERIES COMPANY.']).count
      # @ksa_factory2=Classification.where(["FACTORY_NAME_ECCMA= ?", 'SAUDI PIPE SYSTEMS CO. FACTORY']).count
      # @ksa_factory3=Classification.where(["FACTORY_NAME_ECCMA= ?", 'SAUDI STEEL PIPES CO.']).count
      # @ksa_factory4=Classification.where(["FACTORY_NAME_ECCMA= ?", 'AL ZAMIL STEEL HOLDING FACTORY CO']).count
      # @ksa_factory5=Classification.where(["FACTORY_NAME_ECCMA= ?", 'SAUDI MECHANICAL INDUSTRIES FACTORY CO.']).count
      @fac_others=@ksa_top_factory1+@ksa_top_factory2+@ksa_top_factory3+@ksa_top_factory4
      @ksa_factory_others=@classname_count-@fac_others
  end

   def more_details
   vars = request.query_parameters
    @type = vars['TYPE']
      if @type =='classname'
        if params[:search]
            @vs = params[:search]
            @more= Classification.find_by_sql(["SELECT distinct catalog_name,count(*) AS total FROM `classifications` where catalog_name ='#{@vs}'  group by catalog_name ORDER BY total DESC limit 0,15"])
         else
          @more= Classification.find_by_sql(["SELECT distinct catalog_name,count(*) AS total FROM `classifications` group by catalog_name ORDER BY total DESC limit 0,15"])
         end
    else
          if params[:search]
              @vs = params[:search]
            @more= Classification.find_by_sql(["SELECT distinct FACTORY_NAME_ECCMA, FACTORY_ID,count(*) AS total FROM `classifications` where FACTORY_NAME_ECCMA ='#{@vs}'  group by FACTORY_NAME_ECCMA ORDER BY total DESC limit 0,15"])

          else
          @more= Classification.find_by_sql(["SELECT distinct FACTORY_NAME_ECCMA, FACTORY_ID,count(*) AS total FROM `classifications` group by FACTORY_NAME_ECCMA ORDER BY total DESC limit 0,15"])
          end
      end
  end

#   def image_params
#   @id=params[:cat_id]
#   @id1=params[:pictureInput]
#   if @id1
#    @pictureInput=params[:pictureInput].read
#    if @pictureInput.size
#    @sql=Image.where("cat_id = ?",@id).update_all(file_content: @pictureInput)
#    end

# else

# @setting=Setting.where("organization_ID=123")
#     length_sd=params[:len_sd].to_i
#     length_ld=params[:len_ld].to_i
#     @v=params[:task].reject(&:blank?)
#     @class=params[:class]
#     @v1=params[:task]
#     @prop=params[:ids_to_update1]
#     @d=length_sd
#     @e=length_ld

#     results=ActiveRecord::Base.connection.execute("select * from `made_in_ksa`.settings")
#     results.each(:as => :hash) do |res|
#     @z=res["class_prop_sep_SD"]
#     @y=res["prop_value_sep_LD"]
#     @x=res["class_prop_sep_LD"]
#     @sh_case=res["short_desc_case"]
#     @lg_case=res["long_desc_case"]
#     @val_case=res["value_case"]

#   @id=params[:cat_id]

#  a=params[:ids_to_update]
#      b=params[:task]
#      c=params[:ids_to_update1]
#     @as=''
#     @bs=[]
#     @cs=''
#   # @ss=[]
#    # @s1=params[:task1].zip(params[:cat_id],params[:mat_id])
#      @bs=params[:task].zip(params[:ids_to_update1],params[:ids_to_update])

#     @bs.each do |a,b,c|
#       @cs=a
#       @ds=b
#       @es=c

#       if @val_case=='Lower Case'
#     @cs=@cs.downcase
#     @dc=@ds.downcase
#     @es=@es.downcase
#   elsif @val_case=='Sentence Case'
#      @cs=@cs.capitalize
#     @dc=@ds.capitalize
#     @es=@es.capitalize
#   else
#      @cs=@cs.upcase
#     @dc=@ds.upcase
#     @es=@es.upcase
#   end

#       @update=TechnicalSpecification.where('Seq = ? AND property = ? AND cat_id = ? ',@es,@ds,@id).update_all(value: @cs)
#     end

#     @at=''
#     @bt=[]
#     @ct=''
#     @bt=params[:task1].zip(params[:prop],params[:seq_id])
#     @bt.each do |a,b,c|
#       @ct=a
#       @dt=b
#       @et=c
#       if @val_case=='Lower Case'
#     @cs=@ct.downcase
#     @dc=@dt.downcase
#     @es=@et.downcase
#   elsif @val_case=='Sentence Case'
#      @cs=@ct.capitalize
#     @dc=@dt.capitalize
#     @es=@et.capitalize
#   else
#      @cs=@ct.upcase
#     @dc=@dt.upcase
#     @es=@et.upcase
#   end

#       @update1=RxmlReference.where('Seq = ? AND property = ? AND cat_id =?',@et,@dt,@id).update_all(value: @ct)

#     end

 
# # @v=params[:task].reject(&:blank?).join(",")
# #   @class=params[:class]
# #@v1=params[:task]
# # @prop=params[:ids_to_update1]
# # @b=@prop.zip(@v1).delete_if { |x| x[1] == "" }.collect{|y| y[0]+':'+y[1]+','}.join('')
# #@update2=Classification.where('cat_id = ?',@id).update_all({short_description: @class+','+@v,long_description: @class+','+@b,lastmodified: Time.now})
#   @bs=@class 

# @b=@prop.zip(@v1).delete_if{ |x| x[1]==""}.collect{|y| y[0]+@y+y[1]}
#   @b.each do |s|
#      @v.each do |a|
#          @bs1=@bs+@z+a
#       if @bs1.length<=@d
#          @bs=@bs+@z+a
#       end       
#     end
#           @lg=@class+@x+s
#       if @lg.length>=@e
#           @class=@class+@x+s
#       end
#   end

# end


#   if @sh_case=='Lower Case'
#     @bs=@bs.downcase
#   elsif @sh_case=='Sentence Case'|| @lg_case=='Not Set'
#     @bs=@bs.capitalize
#   else 
#     @bs=@bs.upcase
#   end

#   if @lg_case=='Lower Case'
#     @class=@class.downcase
#   elsif @lg_case=='Sentence Case'|| @lg_case=='Not Set'
#     @class=@class.capitalize
#   else
#     @class=@class.upcase
# end
#     @update1=Classification.where('cat_id = ?',@id).update_all({short_description: @bs,long_description: @class}) 

# end
#    redirect_to controller: 'madein_ksa',action: 'view', cat_id: @id
# end



 # def add_material
#
 #   @a=(Classification.maximum("cmm_material_no"))+1
  #  @class_sel=Classification.select("cat_id").where("cmm_material_no = ?")
 # end



def settings
      @lang_id=params[:text_lang_id]
      if params[:langss]
        @lang_name=params[:text_lang_name]
        @county_code=params[:text_lang_country]
        @lang_code=params[:text_lang_code]
        @lang_desc=params[:text_lang_descripition]
        #user_string=@lang_id
          #@insert=LanguageSetting.connection.insert("INSERT INTO language_settings (language_ID) VALUES ('#{@lang_id}')") 
          # sql = "INSERT INTO made_in_ksa.`language_settings`(`language_ID`, `language_code`, `country_code`, `language_name`, `language_description`) SELECT `language_ID`, `language_code`, `country_code`, `language_name`, `language_description` FROM `eotd_prod`.language where language_ID='#{@lang_id}'"
          sql = "INSERT INTO made_in_ksa.`language_settings`(`language_ID`, `language_code`, `country_code`, `language_name`, `language_description`)VALUES ('#{@lang_id}','#{@lang_code}','#{@county_code}','#{@lang_name}','#{@lang_desc}')"
          records_array = ActiveRecord::Base.connection.execute(sql)

          alter_sql="ALTER TABLE made_in_ksa.`trans_lang` ADD `term_content_#{@lang_code}` VARCHAR(255) NOT NULL AFTER `term_content_ar`, ADD `definition_content_#{@lang_code}` LONGTEXT NOT NULL AFTER `term_content_#{@lang_code}`"
            records_array = ActiveRecord::Base.connection.execute(alter_sql)
          #sql_query="UPDATE `language_settings` SET `language_code`=[value-2],`country_code`=[value-3],`language_name`=[value-4],`language_description`=[value-5] WHERE 1"
      end
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
      # @lang_settings=LanguageSetting.all
      @lang_settings=LanguageSetting.find_by_sql(["SELECT * FROM `language_settings`"])       
      @all_lang=LanguageEotd.order('language_ID ASC')
      if @length_ld
      @settings=Setting.where("organization_ID=123").update_all({length_SD: @length_sd,length_LD: @length_ld,
      class_prop_sep_SD: @class_prop_sep_SD,class_prop_sep_LD: @class_prop_sep_LD,prop_value_sep_SD: @prop_val_sep_SD,
      prop_value_sep_LD: @prop_val_sep_LD,charac_sep_SD: @char_sep_SD,charac_sep_LD: @char_sep_LD,short_desc_case: @case_SD,long_desc_case: @case_LD,value_case: @case_val})  
    end
end
  def template_search
    var=request.query_parameters
    #@class_name=var[:cat_id]
    @lid ='0161-1#LG-000001#1'
      if params[:search]
          @vs = params[:search]
          @class_names = CorpIgname.where(["Class_Name like ?","%#{@vs}%"])
        else 
        @class_names=CorpIgname.order('Class_Name ASC')
        @def=CorpIgname.order('Class_Name ASC')

       
         #@list_drop =Term_dn.where("concept_ID = ?",'0161-1#00-000003#1')
        #@class_names=CorpIgname.find_by_sql(["SELECT a.Class_id,a.Class_Name,b.content FROM `corp_ignames` a,definition_dn b where b.language_id='0161-1#LG-000001#1' and b.is_Deprecated=0 and  a.Class_id=b.concept_id"])
         #@madein_ksa = initialize_grid(Classification,:per_page=>10)
         #SELECT a.Class_id,a.Class_Name,b.content FROM made_in_ksa.`corp_ignames` a,eotd_prod.definition_dn b where b.language_id='0161-1#LG-000001#1' and b.is_Deprecated=0 and  a.Class_id=b.concept_id

         #Guardian.select("guardians.family_name, guardians.id as g_id, users.id as u_id,users.name, users.email, users.username, users.address, users.age,users.gender").joins(:user).where(:users => {:u_id => @user_session.id}) 
         #@class_names=CorpIgname.find_by_sql(["SELECT a.Class_id,a.Class_Name,b.content FROM made_in_ksa.`corp_ignames` a,eotd_prod.definition_dn b where b.language_id='0161-1#LG-000001#1' and b.is_Deprecated=0 and  a.Class_id=b.concept_id"])
        # @class_names=CorpIgname.joins(:definition_dn).where(['language_id = ?', '0161-1#LG-000001#1']) 
      end
   end

   def ajax_property
        @num1 = params["query"]
       #num2 = params["num2"].to_i
        # Do something with input parameter and respond as JSON with the output
        #result = num1 
       # @xml_rg = XmlRg.where(["`class`= ?", 'dhileep']) 
       @xml_rg = XmlRg.select("property,propertyRef,Required,Property_Definition").where("class = ? ",@num1)

        # @xml_rg.all.each do |cn|
        #   @list_drop =DefinitonDn.where("concept_ID = ? AND language_id=?",cn.propertyRef,'0161-1#LG-000001#1')
        # end
       # respond_to do |format|
       #      format.json {render :json => {:result => @xml_rg}}
       # end
       respond_to do |format|
            format.html {render :layout => false}
       end
    end


# def add_material
# lan= I18n.locale
#   @id='VALVE,GATE' 
#   @class_name=params[:txt_class]
#   @a=(Classification.maximum("cmm_material_no"))+1
#   @class_sel=Classification.select("cat_id").where("cmm_material_no = ?")
  
#   @vendor=VendorDatum.order('Vendor_Name ASC') 

# #  if params[:search]
# #    @vs = params[:search]
# #   @class=CorpIgname.where(["Class_Name like ?","%#{@vs}%"])
# # else
#   @class=CorpIgname.select(:Class_Name).distinct
#   @vendor=MmFactory.where(["`Last Status` = ? AND  Language = ?",'OPERATIONAL',lan])
# #end
#   #@sql1=XmlRg.select("property").where("class = ?",@class).count
# #@test=@class.to_sql
#   @class_1=params[:txt_class]
#     #sql2=ActiveRecord::Base.connection.execute("insert into Classification("cat_id") values ("")")
 
  

# end

def get_template
lan= I18n.locale
@id=params[:class]
@supplier=params[:supplier]
@cmm=params[:cmm]
@sql=XmlRg.select("row,property,propertyRef").where("class = ?",@id).order(:row)
@mfr=BuTemplate.select("Seq,property")
@class=CorpIgname.select("Class_Name,igref,Class_id")
@vendor=MmFactory.where(["`Last Status` = ? AND  Language = ?",'OPERATIONAL',lan])

respond_to do |format|
format.html {render :layout => false}
end
end


 def showclass
    lan= I18n.locale
      vars = request.query_parameters
      @type = vars['TYPE']
    if @type =='all'
      if params[:search]
            @vs = params[:search]
            @madein_ksa = initialize_grid(Classification,conditions:["(cat_id like ? OR short_description like ? OR long_description like ?)","%#{@vs}%","%#{@vs}%","%#{@vs}%"],:per_page=>10)
            @madeinksacount=Classification.where("(cat_id like ? OR short_description like ? OR long_description like ?)","%#{@vs}%","%#{@vs}%","%#{@vs}%").count
        else  
      @madein_ksa = initialize_grid(Classification,:per_page=>10)
      @madeinksacount=Classification.count(:username)
      end
       elsif @type == 'Others'
        actions=['CABLE,POWER,ELECTRICAL','PIPE,METALLIC','WIRE,ELECTRICAL','BATTERY,STORAGE',]
          if params[:search]
              @vs = params[:search]
            #search= 19207
              @madein_ksa = initialize_grid(Classification ,conditions:["(cat_id like ? OR short_description like ? OR long_description like ?) ","%#{@vs}%","%#{@vs}%","%#{@vs}%"], :per_page => 10)
              @madeinksacount=Classification.where("(cat_id like ? OR short_description like ? OR long_description like ?)","%#{@vs}%","%#{@vs}%","%#{@vs}%").count
            else
             @madein_ksa = initialize_grid(Classification ,conditions:['catalog_name NOT IN (?)',actions],:per_page=>10) 
              @madeinksacount=Classification.where('catalog_name NOT IN (?)',actions).count  
            end
        else
          if params[:search]
            @vs = params[:search]
          #search= 19207
            @madein_ksa = initialize_grid(Classification ,conditions:["(cat_id like ? OR short_description like ? OR long_description like ?) ","%#{@vs}%","%#{@vs}%","%#{@vs}%"], :per_page => 10)
            @madeinksacount=Classification.where("(cat_id like ? OR short_description like ? OR long_description like ?)","%#{@vs}%","%#{@vs}%","%#{@vs}%").count
          else
           @madein_ksa = initialize_grid(Classification ,conditions:["catalog_name = ?",@type],:per_page=>10) 
            @madeinksacount=Classification.where("catalog_name = ?",@type).count  
          end
    end
  end


  def showfactory
    lan= I18n.locale
  vars = request.query_parameters
  @type = vars['FACTORY']
  if @type =='all'
    if params[:search]
          @vs = params[:search]
          @madein_ksa = initialize_grid(Classification,conditions:["(cat_id like ? OR short_description like ? OR long_description like ?)","%#{@vs}%","%#{@vs}%","%#{@vs}%"],:per_page=>10)
          @factorycount=Classification.where("(cat_id like ? OR short_description like ? OR long_description like ?)","%#{@vs}%","%#{@vs}%","%#{@vs}%").count
      else  
    @madein_ksa = initialize_grid(Classification,:per_page=>10)
    @factorycount=Classification.count(:username)
    end
     elsif @type == 'Others'
      actions=['24249','3065','1687','25738']
        if params[:search]
            @vs = params[:search]
          #search= 19207
            @madein_ksa = initialize_grid(Classification ,conditions:["(cat_id like ? OR short_description like ? OR long_description like ?) ","%#{@vs}%","%#{@vs}%","%#{@vs}%"], :per_page => 10)
            @factorycount=Classification.where("(cat_id like ? OR short_description like ? OR long_description like ?)","%#{@vs}%","%#{@vs}%","%#{@vs}%").count
          else
           @madein_ksa = initialize_grid(Classification ,conditions:['FACTORY_ID NOT IN (?)',actions],:per_page=>10) 
            @factorycount=Classification.where('FACTORY_ID NOT IN (?)',actions).count  
          end
      else
        if params[:search]
          @vs = params[:search]
        #search= 19207
          @madein_ksa = initialize_grid(Classification ,conditions:["(cat_id like ? OR short_description like ? OR long_description like ?) ","%#{@vs}%","%#{@vs}%","%#{@vs}%"], :per_page => 10)
          @factorycount=Classification.where("(cat_id like ? OR short_description like ? OR long_description like ?)","%#{@vs}%","%#{@vs}%","%#{@vs}%").count
        else
         @madein_ksa = initialize_grid(Classification ,conditions:["FACTORY_ID = ?",@type],:per_page=>10) 
          @factorycount=Classification.where("FACTORY_ID = ?",@type).count  
        end
    end
  end

  # def language
  #   @dist_class = Classification.select(:class_id).distinct
  #   #@dist_class_count = Classification.select(:class_id).distinct.count
  #   #   @dist_class_count.times do |j|
  #   #     tposts = Term_dn.where("concept_ID = ? and language_code = ?  ", @dist_class[j],'en')
  #   #   @posts = tposts if tposts
  #   # end
  #   @type='121'
  #   index = 0 
  #   @dist=ActiveRecord::Base.connection.execute("select distinct class_id from `made_in_ksa`.classifications")
  #     @xxx=@dist.to_a
  #     @yyy=@xxx.join(",")
  #     #@zzz= Array.new(@yyy)

  #    @mm = Term_dn.find_by_sql(["SELECT * FROM `term_dn` where concept_ID in ('#{@zzz}') ORDER BY `concept_ID` DESC"])
  # #@xyz =Term_dn.where('concept_ID IN (?)',@yyy).to_sql

  #   # @yyy.times do |d|
  #     #@tposts = ""
  #   # end 


  #   # dist.each(:as => :hash) do |dis|
  #   #   @xxx=dis["class_id"]
  #   # end
  # end ALTER TABLE `language_setti ngs`  ADD `aaaa` INT NOT NULL  AFTER `language_description`,  ADD `bbbbbbb` INT NOT NULL  AFTER `aaaa`;
def language
    #vars = request.query_parameters
    @lan_code = params[:languages]
    @trans = params[:translate]
    @con=params["query"]
    #@con=vars['concept_ID']
    #@term=vars['term']
    @term=params["term"]
    #@def=vars['def']
    @def=params["def"]
    @lid=params["lid"]

    @term_col_name='term_content_ar'
    @def_col_name='definition_content_ar'

    if @lan_code && @trans
      @col=@lan_code
      @term_col_name='term_content_'+@lan_code
      @def_col_name='definition_content_'+@lan_code
        if @trans=="N"
          @language=TransLang.find_by_sql(["SELECT * FROM `trans_lang` where #{@term_col_name}='' OR #{@def_col_name}=''"])
          # @language=TransLang.where(['#{@term_col_name} = ? OR #{@def_col_name} = ?','',''])
        else 
          @language=TransLang.find_by_sql(["SELECT * FROM `trans_lang` where #{@term_col_name}!='' OR #{@def_col_name}!=''"])
        end
      @lan_setting=LanguageSetting.where('language_code = ?',@lan_code)
    else
      #  @term_col_name='Term_ar'
      # @def_col_name='Definition_ar'
      @col='ar'
      @language=TransLang.order('concept_ID ASC')
      @lan_setting=LanguageSetting.where('language_code = ?','ar')
    end 

    if @con 
      @col_name1='term_content_'+@lid
      @col_name2='definition_content_'+@lid
      update_sql="UPDATE made_in_ksa.`trans_lang` SET `#{@col_name1}`='#{@term}',`#{@col_name2}`='#{@def}' WHERE ID='#{@con}'"
      records_array = ActiveRecord::Base.connection.execute(update_sql)
      #      # records_array = ActiveRecord::Base.connection.execute(alter_sql)
      #   #@update1=Classification.where('concept_ID = ?',@con).update_all({term_content_ar: @term,definition_content_ar: @def}) 
      #redirect_to settings_path, :notice => "Your post has been deleted successfully"
    end
    #@lan_setting=LanguageSetting.where('language_code = ?','ar')
    @lan_set=LanguageSetting.order('language_name ASC')
end
  def delete
    var=request.query_parameters
     @lan_id = params["id"]
     @lc = params["lc"]
      @col_name1='term_content_'+@lc
      @col_name2='definition_content_'+@lc
      sql = "DELETE FROM `made_in_ksa`.`language_settings` WHERE `id`='#{@lan_id}'"
          records_array = ActiveRecord::Base.connection.execute(sql)
      delete_sql="ALTER TABLE made_in_ksa.`trans_lang` DROP `#{@col_name1}`, DROP `#{@col_name2}`"
       records_array = ActiveRecord::Base.connection.execute(delete_sql)

         #ALTER TABLE `trans_lang` DROP `term_content_bg`, DROP `definition_content_bg`;
         #if delete_sql
          #redirect_to settings_path, :notice => "Your post has been deleted successfully"
        #end
       #redirect_to settings_path

  end

  def change_class
    @change_class=params[:class]
    @sql=XmlRg.select("row,property,propertyRef,class,igid").where("class = ?",@change_class).order(:row)
    respond_to do |format|
      format.html {render :layout => false}
    end
  end

  def delete_supp
  lan= I18n.locale
  @val=params[:supp_seq]
  @id1=params[:cat_id]
  # @prop=params[:prop]
   sql = "DELETE FROM `made_in_ksa`.`rxml_references` WHERE `cat_id`='#{@id1}' and `Seq`='#{@val}'"
          records_array = ActiveRecord::Base.connection.execute(sql)
  redirect_to controller: 'madein_ksa',action: 'view', cat_id: @id1
  
end
  
end


