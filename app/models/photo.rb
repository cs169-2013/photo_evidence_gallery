class Photo < ActiveRecord::Base
	mount_uploader :image, ImageUploader

	def create
		Photo.create(params[:photo])
	end

end
