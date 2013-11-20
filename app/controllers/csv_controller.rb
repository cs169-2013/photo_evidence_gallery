class CsvController < ApplicationController
    before_filter :authenticate_admin!

    def index   
    end

    layout "photos"

    def import
        hardcode = "admin169"
        myfile = params[:csv_file]
        csv_text = File.read(myfile.path)
        csv = CSV.parse(csv_text, :headers => true)
        csv.each do |row|
            email = row['email']
            name = row['name']
            password = hardcode #row['password']
            role = row['row']
            new_user = User.new(:email => email, :password => password, :password_confirmation => password, :role => role)
            if !new_user.save
                if email
                    flash[email] = "Failed to create " + email
                else
                    flash[:error] = "Failed to extract data from file"
                    break
                end
            else
                flash[email] = "Successfully created " + email + ". The password is " + hardcode
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
