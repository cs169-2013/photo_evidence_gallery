class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy, :code_image]
  before_action :save_user_info, only: [:create, :update, :make_multiple]
	before_filter :authenticate_user!
  before_filter :authenticate_member!, :except => [:index]

  #GET
  def index
    @sort = params[:edited] || session[:edited]
    @incidents = params[:incident] || session[:incident] 
    if params[:edited] != session[:edited] || params[:incident] != session[:incident]
      session[:edited] = params[:edited]
      session[:incident] = params[:incident]
      redirect_to photos_path(:edited => @sort, :incident => @incidents) and return
    end

    if @incidents == 'All'
    	@photos = Photo.where("photos.edited = ?", @sort == 'true')
  	else
  	  @photos = Photo.where("photos.edited = ? AND photos.incident_name = ?", @sort == 'true', @incidents)
  	end
	  @map_points = @photos.find_all{|x| x.lat != nil && x.lng != nil}

		index_logic
  end

  #GET
  def edit_queue
    redirect_to photos_path(:edited => 'false') and return
  end

  def index_logic
    @photo_pack = [[]]
    counter = 0
    pack_number = 0
    @bin_size = 3
    @photos.each do |photo|
      if counter == @bin_size
        counter = 0
        pack_number += 1
        @photo_pack[pack_number]=[]
      end
      @photo_pack[pack_number] << photo
      counter += 1
    end
  end

  def show
  end

  def new
    @photo = Photo.new
    @info = current_user.info.to_hash
  end

  def edit
    @info = {:incident_name => @photo.incident_name,
    :taken_by => @photo.taken_by,
    :operational_period => @photo.operational_period,
    :team_number => @photo.team_number}
  end

  def create
    save_user_info
    if params[:photo] and params[:photo][:image]
      @photo = make_photo
      if @photo.save
        if !@photo.edited
          redirect_to new_photo_path, notice: "Photo queued."
        else
          redirect_to photo_path(@photo), notice: "Successfully created photo."
        end
      else
        redirect_to new_photo_path(@photo), alert: "Couldn't save to database!"
      end
    else
      redirect_to new_photo_path, alert: "No files chosen!"
    end
  end
  
  #helper used by create and make_multiple
  def make_photo
    if params[:photo][:incident_name] == ""
  	  params[:photo][:incident_name] = "no incident name"
  	end
    photo = Photo.new(photo_params)
    photo.edited = params[:photo][:edited] && params[:photo][:edited]=='1' ? true : false
    return photo
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    save_user_info
    if @photo.update_attributes(photo_params)
      if params[:photo][:rotation]
        @photo.rotate_image
        @photo.rotation = nil
      end
      if params[:photo][:crop_x]
        @photo.crop_image
        @photo.crop_x = nil
        @photo.crop_y = nil
        @photo.crop_w = nil
        @photo.crop_h = nil
      end
      if params[:photo][:edited]
        @photo.edited = params[:photo][:edited]=='1' ? true : false
      end
      @photo.save!
      redirect_to photo_path(@photo), notice: "Successfully updated photo."
    else
      redirect_to photo_path(@photo), alert: "Couldn't update the photo."
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end
	
	# GET
	def multiple_uploads
    @info = current_user.info.to_hash
	end
	
	#POST
	def make_multiple
    save_user_info
		if params[:photos] and params[:photos][:images]
			params[:photos][:images].each do |photo|
				params[:photo] = params[:photos]
		    params[:photo].delete("images")
		    params[:photo][:image] = photo
				@photo = make_photo
				if !@photo.save
          redirect_to photos_multiple_uploads_path, alert: "Couldn't save photo!"
        end
			end
			redirect_to photos_multiple_uploads_path, notice: "Multiple images uploaded"
		else
		  redirect_to photos_multiple_uploads_path, alert: "No files chosen!"
		end
	end
	
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_photo
    @photo = Photo.find(params[:id])
  end

  def save_user_info
    hash = params[:photo]
    def helper(a, b)
      !a || a == "" ? b : a
    end
    if hash
      myInfo = {:incident_name => helper(hash[:incident_name], current_user.info[:incident_name]),
      :taken_by => helper(hash[:taken_by], current_user.info[:taken_by]),
      :operational_period => helper(hash[:operational_period], current_user.info[:operational_period]),
      :team_number => helper(hash[:team_number], current_user.info[:team_number])}
      current_user.info = myInfo
      current_user.save
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def photo_params
    params.require(:photo).permit(:caption, :tags, :incident_name, :operational_period, :team_number, :taken_by, :time_taken, :image, :image_file, :crop_x, :crop_y, :crop_w, :crop_h, :rotation, :lng, :lat)
  end
end
