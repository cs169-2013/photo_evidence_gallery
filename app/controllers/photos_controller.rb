class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :save_user_info, only: [:create, :update, :make_multiple]
  before_filter :authenticate_user!
  before_filter :authenticate_member!, :except => [:index]

  #GET
  def index
    @sort = params[:edited] || session[:edited]
    @incidents = params[:incident] || session[:incident] 
   
    if changed(:edited) || changed(:incident)
      session[:edited] = params[:edited]
      session[:incident] = params[:incident]
      redirect_to photos_path(:edited => @sort, :incident => @incidents) and return
    end

    photo_selector_logic
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
    redirect_to photo_path(@photo), alert: "Couldn't update the photo." and return unless @photo.update_attributes(photo_params)

        @photo.rotate_image
        @photo.crop_image

			@photo.nullify_rotate_and_crop 
      if params[:photo][:edited]
        @photo.edited = params[:photo][:edited]=='1' ? true : false
      end
      @photo.save!
      redirect_to photo_path(@photo), notice: "Successfully updated photo."
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
    redirect_to photos_multiple_uploads_path, alert: "No files chosen!" and return unless params[:photos] and params[:photos][:images]
    params[:photo] = params[:photos].dup
		params[:photo].delete("images")
		params[:photos][:images].each do |photo|    
        params[:photo][:image] = photo
        @photo = make_photo
         redirect_to photos_multiple_uploads_path, alert: "Couldn't save photo!" unless @photo.save
      end
      redirect_to photos_multiple_uploads_path, notice: "Multiple images uploaded"
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_photo
    @photo = Photo.find(params[:id])
  end
	def suih(h,c)
  	 lambda do |symbol|
  	    !h[symbol] || h[symbol].blank? ? c[symbol] : h[symbol]
  	end

	end

  def save_user_info
    hash = params[:photo]
    return unless hash
		xx = suih(hash, current_user.info)
     current_user.info = {:incident_name => xx.call(:incident_name),
              :taken_by => xx.call(:taken_by),
              :operational_period => xx.call(:operational_period),
              :team_number => xx.call(:team_number)}
    current_user.save
  end

  def changed(symbol)
    params[symbol] != session[symbol] 
  end

  def photo_selector_logic
    hash = {:edited => (@sort == 'true'), :incident_name => @incidents}
    @photos = Photo.where(@incidents == 'All' ? {:edited => hash[:edited]} : hash)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def photo_params
    params.require(:photo).permit(:caption, :tags, :incident_name, :operational_period, :team_number, :taken_by, :time_taken, :image, :image_file, :crop_x, :crop_y, :crop_w, :crop_h, :rotation, :lng, :lat)
  end
end
