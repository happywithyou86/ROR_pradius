class ContactFormsController < ApplicationController
	def new
		@contact_form = ContactForm.new
	end

	def create
      if simple_captcha_valid?
        session[:name] = nil
      	session[:email]=nil
        session[:message]=nil
        @contact_form = ContactForm.new(params[:contact_form])
	    @contact_form.request = request
     
        UserMailer.forum_thread(current_user.name,current_user.email,params[:contact_form][:message])
        @status=true

      else
      	session[:name]=params[:contact_form][:name]
      	session[:email]=params[:contact_form][:email]
        session[:message]=params[:contact_form][:message]

        @status=false
        flash[:error] = 'Captcha you enter is invalid'
      end
	  respond_to do |format|
	    format.js{ render layout: false }
	  end
   end
end