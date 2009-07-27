class PasswordResetsController < ApplicationController

	before_filter :load_user_using_perishable_token, :only => [:edit, :update]

	def new  
		render  
	end  

	def create  
		@user = User.search(:email => params[:email])  
		if @user && @user.deliver_password_reset_instructions!
			corpo = "Acesse <b>Link: </b><a href='#{edit_password_reset_url(@user.perishable_token)}'>clique aqui.</a>"

			Email.deliver_padrao(:assunto => "Instruções para recuperação de senha", 
			:corpo => corpo,:para => @user.email)			

			flash[:alert] = "Foi enviado por e-mail a instrução de como alterar a sua senha."  
			redirect_to login_path			  	
		else  
			flash[:alert] = "Nenhum usuário com o e-mail informado!"  
			render :action => :new  
		end  
	end 

	def edit  
	render
	end  

	def update
		@user.password = params[:user][:password]  
		@user.password_confirmation = params[:user][:password_confirmation]  
		if @user.save  
			flash[:alert] = "Senha alterada com sucesso!"  
			redirect_to archives_path
		else  
			render :action => :edit  
		end  
	end  

	private  
	def load_user_using_perishable_token  
		@user = User.find_using_perishable_token(params[:id])

		if !@user 
			flash[:alert] = "Link inválido!"
			redirect_to :controller => "users", :action => "new" 
		end
	end  
	
end
