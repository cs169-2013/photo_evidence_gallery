class CsvController < ApplicationController
	before_filter :authenticate_user!

	def index	
	end

	def import
	    myfile = params[:file]
	    csv_text = File.read(myfile.path)
		csv = CSV.parse(csv_text, :headers => true)
		csv.each do |row|
			email = row['email']
			name = row['name']
			new_user = User.new(:email => email, :password => "admin169", :password_confirmation => "admin169")
			if !new_user.save
				flash[email] = "Failed to create" + email
			end
		end
		redirect_to csv_index_path
  	end
end

# csv_text = File.read(myfile)
# ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{model.table_name}")
# puts "\nUpdating table #{model.table_name}"
# csv = CSV.parse(csv_text, :headers => true)
# csv.each do |row|
#   row = row.to_hash.with_indifferent_access
#   ActiveRecord::Base.record_timestamps = false
#   model.create!(row.to_hash.symbolize_keys)
# end
