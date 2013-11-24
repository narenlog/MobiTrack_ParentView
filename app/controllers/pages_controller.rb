class PagesController < ApplicationController
before_action :check_customer, only: [:map] 

  def home
  end

  def about
  end

  def map
  end

   private
  
    def check_customer
    	#Only allow access if Customer params match mobilenumber and authtoken
      @customer = Customer.find_by(mobilenumber: params[:mobilenumber], authtoken: params[:authtoken] )
    	redirect_to root_path, notice: "Not authorized" if @customer.nil?
	  end


end
