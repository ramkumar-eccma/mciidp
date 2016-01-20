class SourceDataController < ApplicationController
  def chart
    @db_cmm = SourceDatum.count(:id)
      @db_cmm_count=@db_cmm.to_s.size
      #db_cmm_first=@db_cmm.to_s.first(1).to_i
      # @ds= db_cmm_first.to_s.ljust(@db_cmm_count.to_i,'0')
      # @ds_cmm= @ds.to_i * 2
      @db_inv = SourceDatum.where(["FLAG= ?", 'INV']).count
      @db_locinv = SourceDatum.where(["FLAG= ?", 'LINV']).count
      @db_match = SourceDatum.where(["FLAG= ?", 'USV']).count
      @db_nonoff = SourceDatum.where(["FLAG= ?", 'USNV']).count
      @db_other = SourceDatum.where(["FLAG = ?", '']).count
      @db_matchgmv = SourceDatum.where(["FLAG= ?", 'GMV']).count
      @db_matchfrv = SourceDatum.where(["FLAG= ?", 'FRV']).count
      @db_matchukv = SourceDatum.where(["FLAG= ?", 'UKV']).count
      @db_nonoffgmv = SourceDatum.where(["FLAG= ?", 'GMNV']).count
      @db_nonoffrnv = SourceDatum.where(["FLAG= ?", 'FRNV']).count
      @db_nonoffuk = SourceDatum.where(["FLAG= ?", 'UKNV']).count

      @dbref_cmm = ReferenceDatum.count(:id)
      @dbref_inv = ReferenceDatum.where(["TEST= ?", 'INV']).count
      @dbref_locinv = ReferenceDatum.where(["TEST= ?", 'LINV']).count
      @dbref_match = ReferenceDatum.where(["TEST= ?", 'USV']).count
      @dbref_nonoff = ReferenceDatum.where(["TEST= ?", 'USNV']).count
      @dbref_other = ReferenceDatum.where(["TEST = ?", '']).count
      @dbref_matchgmv = ReferenceDatum.where(["TEST= ?", 'GMV']).count
      @dbref_matchfrv = ReferenceDatum.where(["TEST= ?", 'FRV']).count
      @dbref_matchukv = ReferenceDatum.where(["TEST= ?", 'UKV']).count
      @dbref_nonoffgmv = ReferenceDatum.where(["TEST= ?", 'GMNV']).count
      @dbref_nonoffrnv = ReferenceDatum.where(["TEST= ?", 'FRNV']).count
      @dbref_nonoffuk = ReferenceDatum.where(["TEST= ?", 'UKNV']).count

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
      # @db_exclass_count=@db_exclass.to_s.size
      # db_exclass_first=@db_exclass.to_s.first(1).to_i
      # @ds= db_exclass_first.to_s.ljust(@db_exclass_count.to_i,'0')
      # @ds_exclass= @ds.to_i * 2
  end

  def nsnlist
    if params[:search]
      @vs = params[:search]
      #search= 19207
       @cmm = initialize_grid(ReferenceDatum ,conditions: ["CAGE_CD_9250 like ? OR NSN like ? OR REF_NBR_3570 like ? OR NAME like ?  ", "%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%"] , :per_page => 10)  

      else
       @cmm = initialize_grid(ReferenceDatum , :per_page => 10)  
    end
  end

  def source
    vars = request.query_parameters
    @type = vars['TYPE']
    if @type =='all'
        if params[:search]
          @vs = params[:search]
          #search= 19207
           @cmm = initialize_grid(SourceDatum ,conditions: ["CAGEC like ? OR NSN like ? OR PART_NUMBER like ? OR NAME like ? ", "%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%"] , :per_page => 10)
          else
            @cmm = initialize_grid(SourceDatum , :per_page => 10)     
        end
    else
        if params[:search]
          @vs = params[:search]
        #search= 19207
          @cmm = initialize_grid(SourceDatum ,conditions: ["CAGEC like ? OR NSN like ? OR PART_NUMBER like ? OR NAME like ? ","%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%"] , :per_page => 10)

        else
          @cmm = initialize_grid(SourceDatum , conditions: ["FLAG = ? ", @type] , :per_page => 10)   
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
           @cmm = initialize_grid(ReferenceDatum ,conditions: ["CAGE_CD_9250 like ? OR NSN like ? OR  REF_NBR_3570 like ? OR NAME like ? ","%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%"] , :per_page => 10)

          else
            @cmm = initialize_grid(ReferenceDatum , :per_page => 10)     
        end
    else
        if params[:search]
          @vs = params[:search]
        #search= 19207
          @cmm = initialize_grid(ReferenceDatum ,conditions: ["CAGE_CD_9250 like ? OR NSN like ? OR REF_NBR_3570 like ? OR NAME like ? ","%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%"]  , :per_page => 10)

        else
          @cmm = initialize_grid(ReferenceDatum , conditions: ["TEST = ? ", @type] , :per_page => 10)   
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
           @cmm = initialize_grid(SourceDatum ,conditions: ["CAGEC like ? OR NSN like ? OR PART_NUMBER like ? OR NAME like ? ","%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%"] , :per_page => 10)

          else
            @cmm = initialize_grid(SourceDatum , :per_page => 10)     
        end
    else
        if params[:search]
          @vs = params[:search]
        #search= 19207
          @cmm = initialize_grid(SourceDatum ,conditions: ["CAGEC like ? OR NSN like ? OR PART_NUMBER like ? OR NAME like ? ","%#{@vs}%","%#{@vs}%","%#{@vs}%","%#{@vs}%"] , :per_page => 10)

        else
          @cmm = initialize_grid(SourceDatum , conditions: ["FLAG = ? ", @type] , :per_page => 10)   
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
          @count_NSN = ASegment.where(["NSN= ?", @vid])
          #if @count_NSN.count == 1  
             @a_seg = ASegment.where(["NSN= ?", @vid])
         # else
           
           #
        #end
        @nsnmrcxs =Nsnmrcxs.where(["NSN= ?", @vid]) 
        @c_seg =ReferenceDatum.where("NSN = ? ", @vid)
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
    @mm =Term_dn.where("term_ID = ? ", @term )
    @def =Definition.where("definition_ID = ? ", @definition )
    @con_dn =Concept_dn.where("concept_ID = ? AND term_ID = ? ", @esci, @term)
    #   else
    #   render 'sessions/login'
    # end
  end

  def view
    vars = request.query_parameters
    @nsn = vars['NSN']
    @part = vars['PART']
    @cage = vars['CAGE']
    @viewnsn =ReferenceDatum.where("NSN = ? AND CAGE_CD_9250 = ? AND REF_NBR_3570 = ? ", @nsn,@cage,@part )
  end

  def viewsource
    vars = request.query_parameters
    @nsn = vars['NSN']
    @viewnsn =SourceDatum.where("NSN = ? ", @nsn )
  end

  def cage_details
    vars = request.query_parameters
    @cage_code = vars['CAGE']
    @cage_det =CageDetail.where("CAGE_CD = ? ", @cage_code )
  end
end
