class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy, :code_image]
	#before_filter :authenticate_user!

  #GET
  def index
    @sort = params[:sort_e] || params["sort_e"] || session[:sort_e]
    if !@sort
      @sort = 'true'
    end
    
    
    if @sort == 'false'
      if params[:sort_e] != session[:sort_e]
        session[:sort_e] = params[:sort_e]
        redirect_to photos_path(:sort_e => @sort) and return
      end
    	@photos = Photo.where("photos.edited = ?", @sort == 'true')
    else
      @incidents = params[:incident] || session[:incident]    
      if params[:sort_e] != session[:sort_e]
        session[:sort_e] = params[:sort_e]
        redirect_to photos_path(:sort_e => @sort, :incident => @incidents) and return
      end
      if params[:incident] != session[:incident]
        session[:incident] = params[:incident]
        redirect_to photos_path(:sort_e => @sort, :incident => @incidents) and return 
      end
      if @incidents == "All"
      	@photos = Photo.where("photos.edited = ?", @sort == 'true')
    	else
    	  @photos = Photo.where("photos.edited = ? AND photos.incidentName = ?", @sort == 'true', @incidents)
    	end
    end
		index_logic
  end

  #GET
  def edit_queue
    redirect_to photos_path(:sort_e => 'false') and return
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
    @photo = Photo.new(photo_params)

    if @photo.save
      render :crop
    else
      flash[:notice] = "Couldn't save to database!"
      render :new
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    #respond_to do |format|
    #  if @photo.update(photo_params)
    #    format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
    #    format.json { head :no_content }
    #if @photo.edited?
    @photo.edited = true
    if @photo.update_attributes(photo_params)
      redirect_to @photo, notice: "Successfully updated photo."
    else
      render :new
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
				@photo = Photo.new({:image => photo})
				@photo.edited = false
				if @photo.save

        else 
          flash[:notice] = "Couldn't save photo!"
          redirect_to photos_multiple_uploads_path
        end
			end
			flash[:notice] = "multiple images uploaded"
			redirect_to photos_multiple_uploads_path
		else
		  flash[:notice] = "No files chosen!"
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
    params.require(:photo).permit(:caption, :tags, :incidentName, :operationalPeriod, :teamNumber, :contentType, :filename, :binaryData, :image, :image_file, :crop_x, :crop_y, :crop_w, :crop_h, :rotation)
  end
end
