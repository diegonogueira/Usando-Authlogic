class Email < ActionMailer::Base
  
 #Email padrao
 def padrao(options = {})
		
	 email = "elisa.pingret@d3i.com.br"	
		
	 recipients options[:para] || "" 
	 from options[:from] || email  
	 subject options[:assunto]  || ""
	 reply_to options[:responder] || email
	 body :corpo => options[:corpo] || email
 end  

end
