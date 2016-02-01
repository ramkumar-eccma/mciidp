class SourceDataController < ApplicationController
 
  def chart
      @db_cmm = SourceDatum.count(:id)
      @db_cmm_count=@db_cmm.to_s.size
      #db_cmm_first=@db_cmm.to_s.first(1).to_i
      # @ds= db_cmm_first.to_s.ljust(@db_cmm_count.to_i,'0')
      # @ds_cmm= @ds.to_i * 2
      @db_inv = SourceDatum.where(["ECCMA_FLAG= ?", 'INV']).count
      @db_locinv = SourceDatum.where(["ECCMA_FLAG= ?", 'LINV']).count
      @db_match = SourceDatum.where(["ECCMA_FLAG= ?", 'USV']).count
      @db_nonoff = SourceDatum.where(["ECCMA_FLAG= ?", 'USNV']).count
      @db_other = SourceDatum.where(["ECCMA_FLAG = ?", '']).count
      @db_matchgmv = SourceDatum.where(["ECCMA_FLAG= ?", 'GMV']).count
      @db_matchfrv = SourceDatum.where(["ECCMA_FLAG= ?", 'FRV']).count
      @db_matchukv = SourceDatum.where(["ECCMA_FLAG= ?", 'UKV']).count
      @db_nonoffgmv = SourceDatum.where(["ECCMA_FLAG= ?", 'GMNV']).count
      @db_nonoffrnv = SourceDatum.where(["ECCMA_FLAG= ?", 'FRNV']).count
      @db_nonoffuk = SourceDatum.where(["ECCMA_FLAG= ?", 'UKNV']).count

      @dbref_cmm = ReferenceDatum.count(:id)
      @dbref_inv = ReferenceDatum.where(["ECCMA_TEST= ?", 'INV']).count
      @dbref_locinv = ReferenceDatum.where(["ECCMA_TEST= ?", 'LINV']).count
      @dbref_match = ReferenceDatum.where(["ECCMA_TEST= ?", 'USV']).count
      @dbref_nonoff = ReferenceDatum.where(["ECCMA_TEST= ?", 'USNV']).count
      @dbref_other = ReferenceDatum.where(["ECCMA_TEST = ?", '']).count
      @dbref_matchgmv = ReferenceDatum.where(["ECCMA_TEST= ?", 'GERV']).count
      @dbref_matchfrv = ReferenceDatum.where(["ECCMA_TEST= ?", 'FRV']).count
      @dbref_matchukv = ReferenceDatum.where(["ECCMA_TEST= ?", 'UKV']).count
      @dbref_nonoffgmv = ReferenceDatum.where(["ECCMA_TEST= ?", 'GMNV']).count
      @dbref_nonoffrnv = ReferenceDatum.where(["ECCMA_TEST= ?", 'FRNV']).count
      @dbref_nonoffuk = ReferenceDatum.where(["ECCMA_TEST= ?", 'UKNV']).count

      @db_valid=@db_match+@db_matchgmv+@db_matchfrv+@db_matchukv+@db_nonoff+@db_other+@db_nonoffgmv+@db_nonoffrnv+@db_nonoffuk
     
      @db_invalid=@db_inv+@db_locinv

      @db_usa=@db_match+@db_nonoff
      @db_gbr=@db_matchukv+@db_nonoffuk
      @db_deu=@db_matchgmv+@db_nonoffgmv
      @db_fra=@db_matchfrv+@db_nonoffrnv
      #@db_inv_count=@db_inv.to_s.size

      # @db_classification = Classification.count(:cat_id)
      # @db_classification_count=@db_classification.to_s.size
      # db_classification_first=@db_classification.to_s.first(1).to_i
      # @ds= db_classification_first.to_s.ljust(@db_classification_count.to_i,'0')
      # @ds_classification= @ds.to_i * 2
      @db_classification = Classification.count(:cat_id)
      @db_classtotal =250000
      @db_classbalance = @db_classtotal-@db_classification

      # @db_factory = Factory.count(:FPKID)
      # @db_factory_count=@db_factory.to_s.size
      # db_factory_first=@db_factory.to_s.first(1).to_i
      # @ds= db_factory_first.to_s.ljust(@db_factory_count.to_i,'0')
      # @ds_factory= @ds.to_i * 2

      @db_factory = MmFactory.where(["Language= ?", 'en']).count
      #@db_factory = MmFactory.count(:id)
      @db_facttotal = @db_factory*2
      @db_factbalance = @db_facttotal-@db_factory
      @db_cansug = MmFactory.where(["`Last Status`= ?", 'Cancel Suggestion']).count
      @db_cancel = MmFactory.where(["`Last Status`= ?", 'CANCELLED']).count
      @db_merged = MmFactory.where(["`Last Status`= ?", 'Merged']).count
      @db_newlic = MmFactory.where(["`Last Status`= ?", 'NEW LICENSE']).count
      @db_newoper = MmFactory.where(["`Last Status`= ?", 'OPERATIONAL']).count
      @db_stop = MmFactory.where(["`Last Status`= ?", 'STOPPED']).count
      @db_under = MmFactory.where(["`Last Status`= ?", 'UNDER CONSTRUCTION']).count
      # @db_factory_count=@db_factory.to_s.size UNDER CONSTRUCTION
      # db_factory_first=@db_factory.to_s.first(1).to_i
      # @ds= db_factory_first.to_s.ljust(@db_factory_count.to_i,'0')
      # @ds_factory= @ds.to_i * 2

      @db_exclass = Ex_classification.count(:cat_id)
      @db_extotal = 1000000
      @db_exbalance = @db_extotal-@db_exclass

      @dbcleansed=SourceDatum.where(["ECCMA_Cleansed= ?", 'y']).count
      # @db_exclass_count=@db_exclass.to_s.size
      # db_exclass_first=@db_exclass.to_s.first(1).to_i
      # @ds= db_exclass_first.to_s.ljust(@db_exclass_count.to_i,'0')
      # @ds_exclass= @ds.to_i * 2
    end


  def nsnlist
    if params[:search]
      @vs = params[:search]
      #search= 19207
       @cmm = initialize_grid(ReferenceDatum ,conditions: ["CAGE_CD_9250 like ? OR ECCMA_NSN like ? OR REF_NBR_3570 like ? OR NAME like ?  ", "%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%"] , :per_page => 10) 

      else
       @cmm = initialize_grid(ReferenceDatum , :per_page => 10)  
    end
  end
  def source
    vars = request.query_parameters
    @type = vars['TYPE']
    @valid= vars['valid']
    @invalid= vars['invalid']
    if @type =='all'
        if params[:search]
          @vs = params[:search]
          #search= 19207
           @cmm = initialize_grid(SourceDatum ,conditions: ["CAGEC like ? OR ECCMA_NSN like ? OR PART_NUMBER like ? OR NAME like ? ", "%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%"] , :per_page => 10)
           @cmmcount=SourceDatum.where("CAGEC like ? OR NSN like ? OR PART_NUMBER like ? OR NAME like ? ", "%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%").count 


          else
            @cmm = initialize_grid(SourceDatum , :per_page => 10)
            @cmmcount=SourceDatum.count(:id)

        end
    elsif @type == 'valid'
      actions=['INV','LINV']
      if params[:search]
          @vs = params[:search]
          #search= 19207
           @cmm = initialize_grid(SourceDatum ,conditions: ["CAGEC like ? OR ECCMA_NSN like ? OR PART_NUMBER like ? OR NAME like ? ", "%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%"] , :per_page => 10)
             @cmmcount=SourceDatum.where("CAGEC like ? OR ECCMA_NSN like ? OR PART_NUMBER like ? OR NAME like ? ", "%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%").count

          else
            @cmm = initialize_grid(SourceDatum , conditions: ['ECCMA_FLAG NOT IN (?)',actions] , :per_page => 10) 
              @cmmcount=SourceDatum.where('ECCMA_FLAG NOT IN (?)',actions).count


        end
      elsif @type == 'invalid'
      actions=['INV','LINV']
      if params[:search]
          @vs = params[:search]
          #search= 19207
           @cmm = initialize_grid(SourceDatum ,conditions: ["CAGEC like ? OR ECCMA_NSN like ? OR PART_NUMBER like ? OR NAME like ? ", "%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%"] , :per_page => 10)
            @cmmcount=SourceDatum.where("CAGEC like ? OR ECCMA_NSN like ? OR PART_NUMBER like ? OR NAME like ? ", "%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%").count

          else
            @cmm = initialize_grid(SourceDatum , conditions: ['ECCMA_FLAG IN (?)',actions] , :per_page => 10) 
            @cmmcount=SourceDatum.where('ECCMA_FLAG IN (?)',actions).count    
        end
     elsif @type == 'countrywise'
          if params[:search]
              @vs = params[:search]
              #search= 19207
               @cmm = initialize_grid(SourceDatum ,conditions: ["CAGEC like ? OR ECCMA_NSN like ? OR PART_NUMBER like ? OR NAME like ? ", "%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%"] , :per_page => 10)
                @cmmcount=SourceDatum.where("CAGEC like ? OR ECCMA_NSN like ? OR PART_NUMBER like ? OR NAME like ? ", "%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%").count

              else
                @cmm = initialize_grid(SourceDatum , conditions: ['ECCMA_FLAG = ? OR ECCMA_FLAG = ? ',@valid,@invalid] , :per_page => 10)
                @cmmcount=SourceDatum.where('ECCMA_FLAG = ? OR ECCMA_FLAG = ? ',@valid,@invalid).count         
            end

    else
        if params[:search]
          @vs = params[:search]
        #search= 19207
          @cmm = initialize_grid(SourceDatum ,conditions: ["CAGEC like ? OR ECCMA_NSN like ? OR PART_NUMBER like ? OR NAME like ? ","%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%"] , :per_page => 10)
          @cmmcount=SourceDatum.where("CAGEC like ? OR ECCMA_NSN like ? OR PART_NUMBER like ? OR NAME like ? ", "%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%").count

        else
          @cmm = initialize_grid(SourceDatum , conditions: ["ECCMA_FLAG = ? ", @type] , :per_page => 10)  
          @cmmcount=SourceDatum.where("ECCMA_FLAG = ? ", @type).count 
        end
    end
  end
  def sourceref
    vars = request.query_parameters
    @type = vars['TYPE']

    if @type =='all'
        if params[:search]
          @vs = params[:search]
          #search= 19207
           @cmm = initialize_grid(ReferenceDatum ,conditions: ["CAGE_CD_9250 like ? OR ECCMA_NSN like ? OR  REF_NBR_3570 like ? OR NAME like ? ","%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%"] , :per_page => 10)
            @cmmcount=ReferenceDatum.where("CAGE_CD_9250 like ? OR ECCMA_NSN like ? OR  REF_NBR_3570 like ? OR NAME like ? ","%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%").count

          else
            @cmm = initialize_grid(ReferenceDatum , :per_page => 10)
            @cmmcount=ReferenceDatum.count(:id)     
        end

    else
        if params[:search]
          @vs = params[:search]
        #search= 19207
          @cmm = initialize_grid(ReferenceDatum ,conditions: ["CAGE_CD_9250 like ? OR ECCMA_NSN like ? OR REF_NBR_3570 like ? OR NAME like ? ","%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%"]  , :per_page => 10)
          @cmmcount=ReferenceDatum.where("CAGE_CD_9250 like ? OR ECCMA_NSN like ? OR  REF_NBR_3570 like ? OR NAME like ? ","%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%").count

        else
          @cmm = initialize_grid(ReferenceDatum , conditions: ["ECCMA_TEST = ? ", @type] , :per_page => 10)   
          @cmmcount=ReferenceDatum.where("ECCMA_TEST = ? ", @type).count
        end
    end
  end
  def sourceinv
    vars = request.query_parameters
    @type = vars['TYPE']
    if @type =='all'
        if params[:search]
          @vs = params[:search]
          #search= 19207
           @cmm = initialize_grid(SourceDatum ,conditions: ["CAGEC like ? OR ECCMA_NSN like ? OR PART_NUMBER like ? OR NAME like ? ","%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%"] , :per_page => 10)

          else
            @cmm = initialize_grid(SourceDatum , :per_page => 10)     
        end
    else
        if params[:search]
          @vs = params[:search]
        #search= 19207
          @cmm = initialize_grid(SourceDatum ,conditions: ["CAGEC like ? OR ECCMA_NSN like ? OR PART_NUMBER like ? OR NAME like ? ","%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%"] , :per_page => 10)

        else
          @cmm = initialize_grid(SourceDatum , conditions: ["ECCMA_FLAG = ? ", @type] , :per_page => 10)   
        end
    end
  end
  
  def edit
     #if session[:user_id]
      vars = request.query_parameters
      @vid = vars['NSN']
      @part = vars['PART']
        @cage = vars['CAGE']
        @vendor = vars['vendor']
          @count_NSN = ASegment.where(["ECCMA_NSN= ?", @vid])
          #if @count_NSN.count == 1  
             @a_seg = ASegment.where(["ECCMA_NSN= ?", @vid])
         # else
           
           #
        #end
        @nsnmrcxs =Nsnmrcxs.where(["ECCMA_NSN= ?", @vid]) 
        @c_seg =ReferenceDatum.where("ECCMA_NSN = ? ", @vid)
        @more_info=ReferenceDatum.where("id= ?", @vendor)
      if @vendor
        @classname="show"
      else
        @classname="hide"
      end
      #   else
      #   render 'sessions/login'
      # end
  end
 
  def dictionary_detail
  # if session[:user_id]
    vars = request.query_parameters
    @esci = vars['esci']
    @term = vars['term']
    @definition = vars['def']
    #@mm = User.where("id = ?", 4).select( "user_fname, user_lname")
     # @mm =Term_dn.where("term_ID = ? ", @term )
     # @def =Definition.where("definition_ID = ? ", @definition )
      @con_dn =Term_dn.where("concept_ID = ? AND term_ID = ? AND definition_ID = ? ", @esci, @term ,@definition)
    #   else
    #   render 'sessions/login'
    # end
  end
   def view
      vars = request.query_parameters
      @nsn = vars['NSN']
      @part = vars['PART']
      @cage = vars['CAGE']
      @viewnsn =ReferenceDatum.where("ECCMA_NSN = ? AND CAGE_CD_9250 = ? AND REF_NBR_3570 = ? ", @nsn,@cage,@part )
         
    end
    def viewsource
      vars = request.query_parameters
      @nsn = vars['NSN']
       @viewnsn =SourceDatum.where("ECCMA_NSN = ? ", @nsn )
   end


  def cage_details
    vars = request.query_parameters
    @cage_code = vars['CAGE']
      @cage_details =CageDetail.where("CAGE_CD = ? ", @cage_code )
  end

  def morensn
      #Force Given 
      @db_morecmm = SourceDatum.count(:FORCE_NAME)
      @db_morecommon = SourceDatum.where(["`FORCE_NAME` LIKE ?", '%COMMON%']).count
      @db_morenull = SourceDatum.where.not(FORCE_NAME: nil).count
      @db_moremsd = SourceDatum.where(["`FORCE_NAME` LIKE ?", '%MSD%']).count
      @db_morersadf = SourceDatum.where(["`FORCE_NAME` LIKE ?", '%RSADF%']).count
      @db_morersaf = SourceDatum.where(["`FORCE_NAME` LIKE ?", '%RSAF%']).count
      @db_morersdf = SourceDatum.where(["`FORCE_NAME` LIKE ?", '%RSDF%']).count
      @db_morerslf = SourceDatum.where(["`FORCE_NAME` LIKE ?", '%RSLF%']).count
      @db_morersnf = SourceDatum.where(["`FORCE_NAME` LIKE ?", '%RSNF%']).count


      # Force Available

      @db_morecmm_avil = SourceDatum.find_by_sql(["SELECT * FROM `source_data` where ECCMA_FLAG in ('USV','FRV','GMV','UKV') ORDER BY `CAGEC` DESC"]).count
      @db_morecmm_common=420      
      @db_morecmm_msd = 0
      @db_morecmm_rsadf = 2948
      @db_morecmm_rsaf = 12613
      @db_morecmm_rsdf = 2482
      @db_morecmm_rslf = 4792
      @db_morecmm_rsnf = 2129
      @db_morecmm_null = 25780


      #Cage Code Given

      @db_morecage = SourceDataCage.find_by_sql(["SELECT sum(cou) as cagetotal FROM `source_data_cages` where CAGEC is NOT NULL"])
      @more_cagecode_1 = SourceDataCage.find_by_sql(["SELECT * FROM `source_data_cages` where CAGEC is NOT NULL ORDER BY `cou` DESC limit 0,1"])
      @more_cagecode_2 = SourceDataCage.find_by_sql(["SELECT * FROM `source_data_cages` where CAGEC is NOT NULL ORDER BY `cou` DESC limit 1,1"])
      @more_cagecode_3 = SourceDataCage.find_by_sql(["SELECT * FROM `source_data_cages` where CAGEC is NOT NULL ORDER BY `cou` DESC limit 2,1"])
      @more_cagecode_4 = SourceDataCage.find_by_sql(["SELECT * FROM `source_data_cages` where CAGEC is NOT NULL ORDER BY `cou` DESC limit 3,1"])
      @more_cagecode_5 = SourceDataCage.find_by_sql(["SELECT * FROM `source_data_cages` where CAGEC is NOT NULL ORDER BY `cou` DESC limit 4,1"])

      #@moreother_cage=@db_morecage-@other_cage

      #Cage Code Available

      @db_Availmorecage = SourceDataCageMatch.find_by_sql(["SELECT sum(cou) as total FROM `source_data_cage_matches`"])
      @more_Availcagecode_1 = SourceDataCageMatch.find_by_sql(["SELECT * FROM `source_data_cage_matches` limit 0,1"])
      @more_Availcagecode_2 = SourceDataCageMatch.find_by_sql(["SELECT * FROM `source_data_cage_matches` limit 1,1"])
      @more_Availcagecode_3 = SourceDataCageMatch.find_by_sql(["SELECT * FROM `source_data_cage_matches` limit 2,1"])
      @more_Availcagecode_4 = SourceDataCageMatch.find_by_sql(["SELECT * FROM `source_data_cage_matches` limit 3,1"])
      @more_Availcagecode_5 = SourceDataCageMatch.find_by_sql(["SELECT * FROM `source_data_cage_matches` limit 4,1"])

      #Country Given

      @more_country = SourceDatum.find_by_sql(["SELECT count(*) as total FROM `source_data` where country_eccma!='NULL' ORDER BY `CAGEC` DESC"])
      @more_countrycode_1 = SourceDatum.find_by_sql(["SELECT distinct COUNTRY_ECCMA, count(*) as total FROM `source_data` where COUNTRY_ECCMA!='NULL' group by COUNTRY_ECCMA order by total DESC limit 0,1"])
      @more_countrycode_1 = SourceDatum.find_by_sql(["SELECT distinct COUNTRY_ECCMA, count(*) as total FROM `source_data` where COUNTRY_ECCMA!='NULL' group by COUNTRY_ECCMA order by total DESC limit 0,1"])
      @more_countrycode_2 = SourceDatum.find_by_sql(["SELECT distinct COUNTRY_ECCMA, count(*) as total FROM `source_data` where COUNTRY_ECCMA!='NULL' group by COUNTRY_ECCMA order by total DESC limit 1,1"])
      @more_countrycode_3 = SourceDatum.find_by_sql(["SELECT distinct COUNTRY_ECCMA, count(*) as total FROM `source_data` where COUNTRY_ECCMA!='NULL' group by COUNTRY_ECCMA order by total DESC limit 2,1"])
      @more_countrycode_4 = SourceDatum.find_by_sql(["SELECT distinct COUNTRY_ECCMA, count(*) as total FROM `source_data` where COUNTRY_ECCMA!='NULL' group by COUNTRY_ECCMA order by total DESC limit 3,1"])
      @more_countrycode_5 = SourceDatum.find_by_sql(["SELECT distinct COUNTRY_ECCMA, count(*) as total FROM `source_data` where COUNTRY_ECCMA!='NULL'  group by COUNTRY_ECCMA order by total DESC limit 4,1"])

      #Country Available

      @more_Availcountry = SourceDatum.find_by_sql(["SELECT COUNTRY_ECCMA,count(*) As total FROM `source_data` where ECCMA_FLAG in ('UKV','GMV','FRV','USV')"])

      @more_Availcountrycode_1 = SourceDatum.find_by_sql(["SELECT COUNTRY_ECCMA,count(*) As total FROM `source_data` where ECCMA_FLAG='USV'"])

      @more_Availcountrycode_2 = SourceDatum.find_by_sql(["SELECT COUNTRY_ECCMA,count(*) As total FROM `source_data` where ECCMA_FLAG='FRV'"])

      @more_Availcountrycode_3 = SourceDatum.find_by_sql(["SELECT COUNTRY_ECCMA,count(*) As total FROM `source_data` where ECCMA_FLAG='GMV'"])

      @more_Availcountrycode_4 = SourceDatum.find_by_sql(["SELECT COUNTRY_ECCMA,count(*) As total FROM `source_data` where ECCMA_FLAG='ukv'"])

      
  end
  def cleansed
    if params[:search]
      @vs = params[:search]
      #search= 19207
       @cleansed = initialize_grid(CmmClassification ,conditions:["(cat_id like ? OR short_description like ? OR long_description like ?) ","%#{@vs}%","%#{@vs}%","%#{@vs}%"], :per_page => 10) 
        @cleansedcount=CmmClassification.where("(cat_id like ? OR short_description like ? OR long_description like ?)","%#{@vs}%","%#{@vs}%","%#{@vs}%").count

      else
       @cleansed = initialize_grid(CmmClassification , :per_page => 10)
       @cleansedcount=CmmClassification.count(:cat_id)
    end
  end
  def editcleansed
    vars = request.query_parameters
    @id = vars['cat_id']
    @data=CmmClassification.where("cat_id = ? ",@id)
    @technical=CmmTechnicalSpecification.select("propertyRef","value","source").where("cat_id = ? ",@id)
    @reference=CmmRxmlReference.select("property","value","value2").where("cat_id = ?",@id)
  end

  #  def edit
  #    if session[:user_id]
  #     vars = request.query_parameters
  #     @vid = vars['NSN']
  #     @part = vars['PART']
  #       @cage = vars['CAGE']
  #         @count_NSN = ASegment.where(["NSN= ?", @vid])
  #         if @count_NSN.count == 1  
  #            @a_seg = ASegment.where(["NSN= ?", @vid])
  #         else
           
  #           respond_to do |format|
  #           format.html { redirect_to nsnlist_path, notice: 'Not found in Classification Table' }
  #         end
  #       end
  #       @nsnmrcxs =Nsnmrcxs.where(["NSN= ?", @vid]) 
  #       @c_seg =ReferenceDatum.where("NSN = ? AND CAGE_CD_9250 = ? AND REF_NBR_3570 = ? ", @vid,@cage,@part )
  #       else
  #       render 'sessions/login'
  #     end
  #   end
    
  #   def viewsource
  #     if session[:user_id]
  #       vars = request.query_parameters
  #       @nsn = vars['NSN']
  #        @viewnsn =SourceDatum.where("NSN = ? ", @nsn )
  #     else
  #       render 'sessions/login'
  #     end
  #  end 

  #   def view
  #     if session[:user_id]
  #       vars = request.query_parameters
  #       @nsn = vars['NSN']
  #       @part = vars['PART']
  #       @cage = vars['CAGE']
  #        @viewnsn =ReferenceDatum.where("NSN = ? AND CAGE_CD_9250 = ? AND REF_NBR_3570 = ? ", @nsn,@cage,@part )
  #         else
  #         render 'sessions/login'
  #       end
  #   end

  #   def dictionary_detail
  #      if session[:user_id]
  #       vars = request.query_parameters
  #       @esci = vars['esci']
  #       @term = vars['term']
  #       @definition = vars['def']
  #       #@mm = User.where("id = ?", 4).select( "user_fname, user_lname")
  #        @mm =Term_dn.where("term_ID = ? ", @term )
  #        @def =Definition.where("definition_ID = ? ", @definition )
  #         @con_dn =Concept_dn.where("concept_ID = ? AND term_ID = ? ", @esci, @term)
  #         else
  #         render 'sessions/login'
  #       end
  #   end



end
