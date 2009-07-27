class UserSessionsController < ApplicationController
 
 def new
   @user_session = UserSession.new
 end
 
 def create
   @user_session = UserSession.new(params[:user_session])
   if @user_session.save
   	if current_user.status #verifica se o usuário esta ativo
			redirect_back_or_default login_path
		else
			flash[:notice] = "Seu usuário ainda não está ativo."
			destroy
		end
   else
     render :action => :new
   end
 end
 
 def destroy
   current_user_session.destroy
   redirect_back_or_default login_path
 end
  
  
end
 

