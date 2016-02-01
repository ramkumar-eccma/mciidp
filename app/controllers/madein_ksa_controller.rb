class MadeinKsaController < ApplicationController
  def show
  lan= I18n.locale
  vars = request.query_parameters
  @type = vars['TYPE']
  if @type =='AVAIL'
    if params[:search]
          @vs = params[:search]
          @madein_ksa = initialize_grid(Classification,conditions:["(cat_id like ? OR short_description like ? OR long_description like ?)","%#{@vs}%","%#{@vs}%","%#{@vs}%"],:per_page=>10)
          @madeinksacount=Classification.where("(cat_id like ? OR short_description like ? OR long_description like ?)","%#{@vs}%","%#{@vs}%","%#{@vs}%").count
      else  
    @madein_ksa = initialize_grid(Classification,:per_page=>10)
    @madeinksacount=Classification.count(:username)
    end
      else
        if params[:search]
          @vs = params[:search]
        #search= 19207
          @madein_ksa = initialize_grid(Classification ,conditions:["(cat_id like ? OR short_description like ? OR long_description like ?) ","%#{@vs}%","%#{@vs}%","%#{@vs}%"], :per_page => 10)
          @madeinksacount=Classification.where("(cat_id like ? OR short_description like ? OR long_description like ?)","%#{@vs}%","%#{@vs}%","%#{@vs}%").count
        else
         @madein_ksa = initialize_grid(Classification,:per_page=>10) 
          @madeinksacount=Classification.count(:username)  
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
  
        @top_factory1 =Classification.find_by_sql(["SELECT distinct FACTORY_NAME,FACTORY_ID,count(*) as total FROM `classifications` where FACTORY_NAME!='NULL' group by FACTORY_NAME ORDER BY `total` DESC limit 0,1"])
        @top_factory2 =Classification.find_by_sql(["SELECT distinct FACTORY_NAME,FACTORY_ID,count(*) as total FROM `classifications` where FACTORY_NAME!='NULL' group by FACTORY_NAME ORDER BY `total` DESC limit 1,1"])
        @top_factory3 =Classification.find_by_sql(["SELECT distinct FACTORY_NAME,FACTORY_ID,count(*) as total FROM `classifications` where FACTORY_NAME!='NULL' group by FACTORY_NAME ORDER BY `total` DESC limit 2,1"])
        @top_factory4 =Classification.find_by_sql(["SELECT distinct FACTORY_NAME,FACTORY_ID,count(*) as total FROM `classifications` where FACTORY_NAME!='NULL' group by FACTORY_NAME ORDER BY `total` DESC limit 3,1"])

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


      # @ksa_factory1=Classification.where(["FACTORY_NAME= ?", 'NATIONAL BATTERIES COMPANY.']).count
      # @ksa_factory2=Classification.where(["FACTORY_NAME= ?", 'SAUDI PIPE SYSTEMS CO. FACTORY']).count
      # @ksa_factory3=Classification.where(["FACTORY_NAME= ?", 'SAUDI STEEL PIPES CO.']).count
      # @ksa_factory4=Classification.where(["FACTORY_NAME= ?", 'AL ZAMIL STEEL HOLDING FACTORY CO']).count
      # @ksa_factory5=Classification.where(["FACTORY_NAME= ?", 'SAUDI MECHANICAL INDUSTRIES FACTORY CO.']).count
      @fac_others=@ksa_top_factory1+@ksa_top_factory2+@ksa_top_factory3+@ksa_top_factory4
      @ksa_factory_others=@classname_count-@fac_others
  end

  def view
		var=request.query_parameters
		@id=var[:cat_id]
		@data=Classification.where("cat_id = ? ",@id)
		@data1=TechnicalSpecification.select("property","value").where("cat_id = ? ",@id)
		@data2=RxmlReference.select("property","value").where("cat_id = ?",@id)

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
			     	@more= Classification.find_by_sql(["SELECT distinct FACTORY_NAME, FACTORY_ID,count(*) AS total FROM `classifications` where FACTORY_NAME ='#{@vs}'  group by FACTORY_NAME ORDER BY total DESC limit 0,15"])

			    else
			    @more= Classification.find_by_sql(["SELECT distinct FACTORY_NAME, FACTORY_ID,count(*) AS total FROM `classifications` group by FACTORY_NAME ORDER BY total DESC limit 0,15"])
			    end
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
end
