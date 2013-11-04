class Photo < ActiveRecord::Base
<<<<<<< HEAD
	
	def image_file=(input_data)
		self.filename = input_data.original_filename
		self.contentType = input_data.content_type.chomp
		self.binaryData = input_data.read
		# extract metadata plz
=======
	mount_uploader :image, ImageUploader
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_image
	def create
		Photo.create(params[:photo])
>>>>>>> CropBranch
	end

  def crop_image
    image.recreate_versions! if crop_x.present?
  end

end
