class ActiveUsersController < ApplicationController

	def edit
		@user = User.find_using_perishable_token(params[:id])
		if @user
			if @user.update_attributes(:status => true)
				send_email_actived_user 
				flash[:notice] = "Usuário ativado com sucesso!"  
				redirect_to edit_user_path(@user)
			end  					
		else
			flash[:notice] = "Token inválido"
			render :action => :edit
		end 

	end 

	private

	#Envia email (usuário ativado)
	def send_email_actived_user
		corpo = <<-CODE
		<b>Seu cadastro foi aceito!<br></b>
		<b>Data do cadastro: </b>#{@user.created_at}<br>
		<b>Login: </b>#{@user.login}<br>
		<b>E-mail: </b>#{@user.email}<br>
		CODE

		Email.deliver_padrao(:corpo => corpo, :assunto => "Cadastro Aceito", :para => @user.email)
 
	end 	
	
end
