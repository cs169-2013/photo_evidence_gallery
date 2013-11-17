class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy, :code_image]
	before_filter :authenticate_user!

  #GET
  def index
    @sort = params[:edited] || params["edited"] || session[:edited]
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
  end

  def edit
  end

  def create
    if params[:photo] and params[:photo][:image]
      @photo = make_photo
      if @photo.save
        if !@photo.edited
          flash[:notice] = "Photo queued."
          redirect_to new_photo_path
        else
          render :crop
        end
      else
        redirect_to action: 'new', error: "Couldn't save to database!"
      end
    else
      redirect_to action: 'new', error: "No files chosen!"
    end
  end
  
  #helper used by create and make_multiple
  def make_photo
    if params[:photo][:incident_name] == ""
  	  params[:photo][:incident_name] = "no incident name"
  	end
    photo = Photo.new(photo_params)
    photo.edited = (params[:photo][:edited]||params[:photo][:edited]=='1')? true : false
    return photo
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    @photo.edited = true
    if @photo.update_attributes(photo_params)
      redirect_to @photo, notice: "Successfully updated photo."
    else
      redirect_to action: 'new', error: "Couldn't update the photo."
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
	end
	
	#POST
	def make_multiple
		if params[:photos] and params[:photos][:images]
			params[:photos][:images].each do |photo|
				params[:photo] = params[:photos]
		    params[:photo].delete("images")
		    params[:photo][:image] = photo
				@photo = make_photo
				if !@photo.save
          flash[:error] = "Couldn't save photo!"
          redirect_to photos_multiple_uploads_path
        end
			end
			flash[:notice] = "Multiple images uploaded"
			redirect_to photos_multiple_uploads_path
		else
		  flash[:error] = "No files chosen!"
		  redirect_to photos_multiple_uploads_path
		end
	end
	
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_photo
    @photo = Photo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def photo_params
    params.require(:photo).permit(:caption, :tags, :incident_name, :operational_period, :team_number, :taken_by, :time_taken, :image, :image_file, :crop_x, :crop_y, :crop_w, :crop_h, :rotation, :lng, :lat)
  end
end
