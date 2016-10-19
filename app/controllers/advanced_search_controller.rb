class AdvancedSearchController < ApplicationController
  def listall
      @lang = params[:locale]
      @search_all = params[:search]
      if params[:search]
        @reqgetdata=params[:class_name]
        @reqdata=params[:class_name].split('/')
        @res_igid = @reqdata[0]
        @class = @reqdata[1]
        @res_igid=Base64.decode64(@res_igid)

        @req_chr=params[:chr]
        @cmb_value=params[:cmb_value]

        @req_class_name=params[:req_classname]

        @req_chr_ref=params[:chr_ref] 
        @req_cmb_value_ref=params[:cmb_value_ref]

        if(@req_chr != nil && @req_chr != 0) 
          @req_chr_count = params[:chr].size
          @cmb_value_count = params[:cmb_value].size
        end

        if(@req_chr_ref != nil && @req_chr_ref != 0)
          @req_chr_ref_count = params[:chr_ref].size  
          @req_cmb_value_ref_count = params[:cmb_value_ref].size
        end

        @queryform=""
        @query_val =""
        @qryidentify=""

        if @req_class_name!= ''
          @queryform= @queryform + " classifications.Class='" + @req_class_name + "' AND classifications.language = '" + @lang + "'"
        end

        if(@req_chr != nil && @req_chr != 0)
          @val=""
          @req_chr_count.times do |d|
            if @cmb_value[d]!=""
              if @val==""
                @val =  @val + @req_chr[d] + ":" + @cmb_value[d] 
              else
                @val =  @val + "%" + @req_chr[d] + ":" + @cmb_value[d] 
              end 
            end
          end
        end

        if @val!=""
          @list_details_cou = TechnicalSpecification.joins(:Classification).select(:property,:Class,:igid).uniq.where("technical_specifications.igid = '#{@res_igid}' AND technical_specifications.value <> '' AND classifications.long_description like '%#{@val}%' AND technical_specifications.igid=classifications.igid AND classifications.language ='#{@lang}' and technical_specifications.language = '#{@lang}'").order(Seq: :asc) 
          @list_details = TechnicalSpecification.joins(:Classification).select(:property, :value).uniq.where("technical_specifications.igid = '#{@res_igid}' AND technical_specifications.value <> '' AND classifications.long_description like '%#{@val}%' AND technical_specifications.igid=classifications.igid AND classifications.language ='#{@lang}' and technical_specifications.language = '#{@lang}'").order(Seq: :asc)     
        else
            @list_details_cou = TechnicalSpecification.where("igid = ? AND value <> ? AND language = ? ", @res_igid,'',@lang).select(:property,:Class,:igid).distinct.order(Seq: :asc)
            @list_details = TechnicalSpecification.select(:property, :value).uniq.where("igid = ? AND value <> ? AND language = ? ", @res_igid,'',@lang).order(Seq: :asc)    
        end 

        if(@req_chr != nil && @req_chr != 0)
          @req_chr_count.times do |i|      
            if @cmb_value[i]!=""
              if @query_val=='' 
                @query_val = @query_val + "classifications.language ='"+ @lang +"' and (classifications.long_description like "  + "'%" + @req_chr[i] + ":" + @cmb_value[i] + "%')"
              else
                @query_val = @query_val + " and (classifications.long_description like "  + "'%" + @req_chr[i] + ":" + @cmb_value[i] + "%')"  
              end     
            end
          end
        end  

        if @query_val!=""
          @queryform = @queryform +" and (" + @query_val +")";
        end

        if(@req_chr_ref != nil && @req_chr_ref != 0)
          @req_chr_ref_count.times do |j|
            if @req_cmb_value_ref[j]!=""
              if @qryidentify==''       
                @qryidentify = @qryidentify + "rxml_references.language = '"+ @lang + "' and (rxml_references.property = '"  + @req_chr_ref[j] + "'" "and rxml_references.value ='" + @req_cmb_value_ref[j] + "')"
              else
                @qryidentify = @qryidentify + " OR (rxml_references.property = '"  + @req_chr_ref[j] + "'" "and rxml_references.value ='" + @req_cmb_value_ref[j] + "')"  
              end     
            end 
          end
        end

        if @qryidentify!=""
          if @query_val!=""
            @queryform= @query_val +" and ("+ @qryidentify +")"
          else
            @queryform= "("+ @qryidentify +")"
          end 
          @result_all = Classification.joins(:RxmlReference).uniq.where(@queryform)   
          # @result_all1 = Classification.joins(:RxmlReference).uniq.where(@queryform).to_sql
        else
          @result_all = Classification.uniq.where(@queryform)
          # @result_all1 = Classification.uniq.where(@queryform).to_sql
        end
        @total_count = @result_all.count   

        @classifiy=Classification.select(:Class,:igid).uniq.where("Class <> ? AND datedeleted = ? AND igid <> ? AND long_description <> ? AND language = ? ", '','0000-00-00 00:00:00','','',@lang).order(Class: :asc)

        @list_rxml = RxmlReference.select(:property, :value).uniq.where("igid = ? AND value <> ? AND language = ? ", @res_igid,'',@lang).order(Seq: :asc)
        @list_rxml_cou = RxmlReference.where("igid = ? AND value <> ? AND language = ? ", @res_igid,'',@lang).select(:property,:Class,:igid).distinct.order(Seq: :asc)

        # @classifiy=Classification.joins(:TechnicalSpecification).select(:Class,:igid).uniq.where("classifications.Class<>'' and classifications.datedeleted='0000-00-00 00:00:00' and technical_specifications.datedeleted='0000-00-00 00:00:00' and classifications.igid<>''").order(Class: :asc)   
      else
        @classifiy=Classification.select(:Class,:igid).uniq.where("Class <> ? AND datedeleted = ? AND igid <> ? AND long_description <> ? AND language = ? ", '','0000-00-00 00:00:00','','',@lang).order(Class: :asc)
      end
  end
  
  def advsearch_response  
    @language = I18n.locale  
    @check=params[:check] 
    @reqdata=params[:req_igid].split('/')
    @res_igid = @reqdata[0]
    @class = @reqdata[1]
    @res_igid=Base64.decode64(@res_igid)

    @req_chr=params[:chr]
    @cmb_value=params[:cmb_value]

    @req_class_name=params[:req_classname]

    @req_chr_ref=params[:chr_ref] 
    @req_cmb_value_ref=params[:cmb_value_ref]
    
    if(@req_chr != nil && @req_chr != 0) 
      @req_chr_count = params[:chr].size
      @cmb_value_count = params[:cmb_value].size
    end

    if(@req_chr_ref != nil && @req_chr_ref != 0)
      @req_chr_ref_count = params[:chr_ref].size  
      @req_cmb_value_ref_count = params[:cmb_value_ref].size
    end    

      @list_details_cou = TechnicalSpecification.where("igid = ? AND value <> ? AND language = ? ", @res_igid,'',@language).select(:property,:Class,:igid).distinct.order(Seq: :asc)
      @list_details = TechnicalSpecification.select(:property, :value).uniq.where("igid = ? AND value <> ?  AND language = ? ", @res_igid,'',@language).order(Seq: :asc)    
      @list_rxml = RxmlReference.select(:property, :Class,:value).uniq.where("igid = ? AND value <> ? AND language = ?  ", @res_igid,'',@language).order(Seq: :asc)
      @list_rxml_cou = RxmlReference.where("igid = ? AND value <> ? AND language = ? ", @res_igid,'',@language).select(:property).distinct.order(Seq: :asc)

    respond_to do |format|
      format.html {render :layout => false}
    end
  end       
end
