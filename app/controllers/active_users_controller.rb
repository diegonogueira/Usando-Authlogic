class ActiveUsersController < ApplicationController

	before_filter :require_user
	before_filter :load_user

	def edit
	end 

	def update
		if @user.update_attributes(:status => true)
			send_email_actived_user 
			flash[:alert] = "Usuário ativado com sucesso!"  
			redirect_to users_path
		else  
			render :action => edit_active_user(@user)
		end  
	end

	private

	def load_user
		@user = User.search(:id => params[:id])
	end

	#Envia email (usuário ativado)
	def send_email_actived_user
		corpo = <<-CODE
		<b>Seu cadastro foi aceito!<br></b>
		<b>Data do cadastro: </b>#{@user.created_at}<br>
		<b>Login: </b>#{@user.username}<br>
		<b>E-mail: </b>#{@user.email}<br>
		CODE

		Email.deliver_padrao(:corpo => corpo, :assunto => "Cadastro Aceito", :para => @user.email)
 
	end 	
	
end
