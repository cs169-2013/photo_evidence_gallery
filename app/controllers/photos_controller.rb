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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_photo
    @photo = Photo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def photo_params
    params.require(:photo).permit(:caption, :tags, :incidentName, :operationalPeriod, :teamNumber, :contentType, :filename, :image, :image_file)
  end
end
