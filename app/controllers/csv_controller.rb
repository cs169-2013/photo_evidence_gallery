class CsvController < ApplicationController
  before_filter :authenticate_admin!
  layout "photos"

  def index   
  end

  def import
    default_password = ENV["DEFAULT_PASSWORD"]
    myfile = params[:csv_file]
    redirect_to csv_index_path, alert: "Please select a file to upload." and return unless myfile
    redirect_to csv_index_path, alert: "Invalid file, please upload a .csv file." and return unless myfile.content_type == "text/csv"
    csv_text = File.read(myfile.path)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      @email = row['email']
      @password = default_password
      @role = row['role']
      if format_correct
        create_user
      end
    end
    redirect_to csv_index_path
  end

  def format_correct
    if !@email || !@role
      flash[SecureRandom.UUID] = "Failed to create a row, did not have email and role"
    elsif !(@email =~ /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i)
      flash[@email] = "Failed to create " + @email + ", did not have a valid email"
    else
      return true
    end
    return false
  end
      

  def create_user
    new_user = User.new(:email => @email, :password => @password, :password_confirmation => @password, :role => @role)
    if !new_user.save
      flash[@email] = "Failed to create " + @email + " " + new_user.errors.messages.to_s
    else
      flash[@email] = "Successfully created " + @email + " as a " + @role + ". The password is " + @password
    end
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
