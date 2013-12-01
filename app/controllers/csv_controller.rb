class CsvController < ApplicationController
    before_filter :authenticate_admin!
    layout "photos"

    def index   
    end

    def import
        default_password = "bamru2013"
        myfile = params[:csv_file]
        if !myfile
          flash[:error] = "Please select a file to upload."
          redirect_to csv_index_path and return
        end
        if myfile.content_type != "text/csv"
          flash[:error] = "Invalid file, please upload a .csv file."
          redirect_to csv_index_path and return
        end
        csv_text = File.read(myfile.path)
        csv = CSV.parse(csv_text, :headers => true)
        csv.each do |row|
            email = row['email']
            name = row['name']
            password = default_password
            role = row['role']
            new_user = User.new(:email => email, :password => password, :password_confirmation => password, :role => role)
            col = email || name || role
            if (!email || !role )
              flash[col] = "Failed to create " + col + ", did not have all information"
            elsif !(email =~ /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i)
              flash[email] = "Failed to create " + email + ", did not have a valid role"
            elsif !new_user.save
              if col 
                  flash[col] = "Failed to create " + col + ", information missing."
              else
                  flash[:error] = "Failed to extract data from file."
                  break
              end
            else
                flash[email] = "Successfully created " + email + ". The password is " + default_password
            end
        end
        redirect_to csv_index_path
    end

    def export
      @users = User.all.sort_by! {|u| u.id}
      respond_to do |format|
        format.html
        format.csv { send_data @users.to_csv }
        format.xls # { send_data @products.to_csv(col_sep: "\t") }
      end
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
