class UserController < ApplicationController
  def list
	@users = User.all
  end

  def edit
	@user = User.find(params[:id])
  end

  # def update
  # 	 @name = params[:user][:name]
  # 	 @id = User.find(params[:user][:id])
    
  #   if params[:user][:password].blank?
  #     params[:user].delete(:password)
  #     params[:user].delete(:password_confirmation)
  #   end

  # 	  User.where(:id => @id).update(:name => @name)	
  #     redirect_to root_path
  # end
  
  def delete
	 User.find(params[:id]).destroy
   redirect_to :action => 'list'
  end
end
