class LangsController < ApplicationController
  def show
	lan= I18n.locale
	vars = request.query_parameters
	@type = vars['TYPE']
	if @type =='all'
		if params[:search]
			@vs = params[:search]
			#search= 19207
			@factory = initialize_grid(MmFactory ,conditions:["(Factory_Name like ? OR Factory_ID like ? OR Factory_Website like ?) AND Language = ?","%#{@vs}%","%#{@vs}%","%#{@vs}%",lan], :per_page => 10)
		else
			@factory = initialize_grid(MmFactory,conditions:["Language = ?",lan],:per_page=>10)     
		end
	else
		if params[:search]
			@vs = params[:search]
			#search= 19207
			@factory = initialize_grid(MmFactory ,conditions:["(Factory_Name like ? OR Factory_ID like ? OR Factory_Website like ?) AND Language = ?","%#{@vs}%","%#{@vs}%","%#{@vs}%",lan], :per_page => 10)
		else
			@factory = initialize_grid(MmFactory,conditions:["`Last Status`= ? AND Language = ?",@type,lan],:per_page=>10)   
		end
	end
  end

  def view
	language =I18n.locale
	#language ='ar'
	var = request.query_parameters
	@data=var['Factory_ID']
	 @show=var['map']
	# @data1="Factory_Name" language
	@name =Factory.select("Value").where("Factory_ID = ? AND Client_seq = ? AND language = ?", @data,'1',language)
	@fname =Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ?", @data,'1',language)
	@fweb =Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'2',language)
	@fpaddress =Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'3',language)
	@fcity =Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'4',language)
	@fdistrict =Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'5',language)
	@fpostal_Code =Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'6',language)
	@fpob =Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'7',language)
	@fpob_city =Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'8',language)
	@fpob_pc =Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'9',language)
	@fstate =Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'10',language)
	@flicense =Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'11',language)
	@fgps=Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'24',language)
	@fblockno =Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'25',language)
	@fnoemp =Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'26',language)
	@frelation =Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'13',language)
	@frelation_title =Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'14',language)
	@frelation_email =Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'15',language)
	@ftp_name =Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'16',language)
	@ftp_title =Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'17',language)
	@ftp_email =Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'18',language)
	@fcs_type=Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'19',language)
	@fland_type=Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'20',language)
	@fsite_land=Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'21',language)
	@find_city=Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'22',language)
	@find_land=Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'23',language)
	@fmfg_isic=Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'28',language)
	@fmfg_capacity=Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'29',language)
	@fmfgcount=Factory.where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'28',language).count
	@fmfg_uom=Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'30',language)
	@fmfg_period=Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Client_seq = ? AND language = ? ", @data,'31',language)
	@fown_org=Factory.select("Value","property","Client_seq").where("Factory_ID = ? AND Seq = ? AND language = ?", @data,'12',language)
	@flast_status=Factory.select("Value","property","Seq").where("Factory_ID = ? AND Client_seq = ? AND language = ?", @data,'27',language)
  end

  def update
  end
end
