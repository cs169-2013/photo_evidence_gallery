class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy, :code_image]

  def index
    @photos = Photo.all
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
			if photo.edited
				@photo_pack[pack_number] << photo
				counter += 1
			end
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
    @photo.edited = true

    if @photo.save
      if params[:photo][:image].present?
        render :crop
      else
        redirect_to @photo, notice: "Successfully created photo."
      end
    else
      render :new
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    @photo.edited = true
    #respond_to do |format|
    #  if @photo.update(photo_params)
    #    format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
    #    format.json { head :no_content }
    @photo = Photo.find(params[:id])

    if @photo.update_attributes(photo_params)
      if params[:photo][:image].present?
        render :crop
      else
        redirect_to @photo, notice: "Successfully update user."
      end
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

  def code_image 
    @image = @photo.binaryData
    send_data @image, :type     => @photo.contentType, 
                      :filename => @photo.filename, 
                      :disposition => 'inline'
  end
	
	# GET
	def multiple_uploads
	end
	
	#POST
	def make_multiple
		if params[:photos] and params[:photos][:images]
			params[:photos][:images].each do |photo|
				@photo = Photo.new({:image_file => photo})
				@photo.edited = false
				@photo.save
#				respond_to do |format|
#				  if @photo.save
#				  
#			  	else
#            format.html { render action: 'make_multiple' }
#            format.json { render :error => 'Image #{@photo} failed to upload' }		  
#				  end
#				end
			end
			flash[:notice] = "multiple images uploaded"
			redirect_to photos_multiple_uploads_path
		else
		  flash[:notice] = "No files chosen!"
		  redirect_to photos_multiple_uploads_path
		end
	end
	
	#GET
	def edit_queue
    @photos = Photo.all
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
			if !photo.edited
				@photo_pack[pack_number] << photo
				counter += 1
		  end
		end
	end
	
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_photo
    @photo = Photo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def photo_params
    params.require(:photo).permit(:caption, :tags, :incidentName, :operationalPeriod, :teamNumber, :contentType, :filename, :binaryData, :image, :image_file, :crop_x, :crop_y, :crop_w, :crop_h)
  end
end
