class Photo < ActiveRecord::Base
	def image_file=(input_data)
		self.filename = input_data.original_filename
		self.contentType = input_data.content_type.chomp
		self.binaryData = input_data.read
	end

	def create
		Photo.create(params[:photo])
	end

end
