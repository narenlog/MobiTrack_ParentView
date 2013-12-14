require 'parse-ruby-client'

class PagesController < ApplicationController
before_action :check_customer, only: [:map] 

  def home
  end

  def about
  end

  def map
    #https://github.com/adelevie/parse-ruby-client#installation
    @customer = Customer.find_by(mobilenumber: params[:mobilenumber], authtoken: params[:authtoken] )  
   

    Parse.init :application_id => "71adOetxcx2qGt2CTBuaIM6kwqq9cl8w2f0npLGQ", :api_key => "Dhi2QW3AaBy8n5fNqk7269SenifhtMhdDrj5tUcb" #Use REST API Key for webapp, Client Key is for Android/iPhone

      #For Parse::User special usage : Use "underscore before User class" to access "/users" REST API URL
      #https://github.com/adelevie/parse-ruby-client#retrieving-users
    school_van_query =  Parse::Query.new("_User").eq("username", @customer.locationtarget) #find the van
      #school_van_results_array = school_van_query.get
      #puts "School Van : ", school_van_results_array[0]
      #school_van_hash = school_van_results_array[0]
      #puts school_van_hash["objectId"]

      #https://parse.com/questions/query-with-filter-on-pointer-field
      #https://github.com/adelevie/parse-ruby-client#relational-queries
     school_van_location_query =  Parse::Query.new("Posts").in_query("user", school_van_query)#find the van's location
     school_van_location_results_hash= school_van_location_query.tap do |q|
                                        q.order_by = "created_at"
                                        q.order = :descending # grab the last location of the van
                                      end.get.first #.last returns hash of object instead of resultset array returned by .get
      #puts school_van_location_results_hash
     puts "Latitude : ", school_van_location_results_hash["location"].latitude
     puts "Longitude : ", school_van_location_results_hash["location"].longitude

      @location_targets = LocationTarget.find_by(title:@customer.locationtarget)#update the location_target's current location
      #puts @location_targets
      #@location_target = @location_targets[0]
      @location_targets.latitude = school_van_location_results_hash["location"].latitude
      @location_targets.longitude = school_van_location_results_hash["location"].longitude
      @location_targets.save

      puts @location_targets.latitude
      puts @location_targets.longitude

      #https://github.com/JonKernPA/gmaps
      #https://github.com/apneadiving/Google-Maps-for-Rails
       @hash = Gmaps4rails.build_markers(@location_targets) do |location_target, marker|
          marker.lat location_target.latitude
          marker.lng location_target.longitude
          marker.title location_target.title
        end

        

  end

   private
  
    def check_customer
    	#Only allow access if Customer params match mobilenumber and authtoken
      @customer = Customer.find_by(mobilenumber: params[:mobilenumber], authtoken: params[:authtoken] )
    	redirect_to root_path, notice: "Not authorized" if @customer.nil?
	  end


end
