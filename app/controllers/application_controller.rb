class ApplicationController < ActionController::Base

	helper :all
	helper_method :current_user_session, :current_user #esses metodos estarão acessíveis no helper também
	filter_parameter_logging :password, :password_confirmation #filtramos os campos de senha, para que o mesmo não aparece legivelmente nos logs.

	#Não use esse método como privado, para que possa interagir com outros plugins(Ex.: o plugin rails_authorization)
	def current_user #retorna o usuário atual
		return @current_user if defined?(@current_user)
		@current_user = current_user_session && current_user_session.record
	end

	private

	def current_user_session #retorna a sessão do usuário atual
		return @current_user_session if defined?(@current_user_session)
		@current_user_session = UserSession.find
	end

	def require_user #informa o que precisa estar logado
		unless current_user
			store_location
			redirect_to new_user_session_url
			return false
		end
	end

	def require_no_user #informa o que não precisa estar logado
		if current_user
			store_location
			redirect_to account_url
			return false
		end
	end

	def store_location #retorna a ultima url que não pode ser acessada, pois o usuário não estava logado
		session[:return_to] = request.request_uri
	end

	def redirect_back_or_default(default) #retorna para a ultima url que não pode ser acessada ou a definida como default
		redirect_to(session[:return_to] || default)
		session[:return_to] = nil
	end

end

