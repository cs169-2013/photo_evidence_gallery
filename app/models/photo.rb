class Photo < ActiveRecord::Base

    mount_uploader :image, ImageUploader
    before_save :extract_geolocation
    attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :rotation
    after_update :crop_image
    

    def extract_geolocation
    	return unless image_exists?

	    @img = Magick::Image.read(image)[0] rescue nil
	    
	    return unless @img
	    img_lat = exif_extractor('GPSLatitude', true)
	    img_lng = exif_extractor('GPSLongitude', true)
	    
	    lat_ref = exif_extractor('GPSLatitudeRef', false)
	    lng_ref = exif_extractor('GPSLongitudeRef', false)
	    
	    return unless img_lat && img_lng && lat_ref && lng_ref

	    
	    latitude = coordinate(img_lat)
	    longitude = coordinate(img_lng)
	    
	    latitude = latitude * -1 if lat_ref == 'S'  # (N is +, S is -)
	    longitude = longitude * -1 if lng_ref == 'W'   # (W is -, E is +)
	    
	    self.lat = latitude
	    self.lng = longitude

	end

	def image_exists?
		image.model.image?
	end

	def exif_extractor(entry, should_split)
		if should_split
			@img.get_exif_by_entry(entry)[0][1].split(', ') rescue nil
		else
			@img.get_exif_by_entry(entry)[0][1] rescue nil
		end
	end

	def coordinate(array)
		to_frac(array[0]) + (to_frac(array[1])/60) + (to_frac(array[2])/3600)
	end

	def to_frac(strng)
	    numerator, denominator = strng.split('/').map(&:to_f)
	    denominator ||= 1
	    numerator/denominator
	end

    def crop_image
      image.recreate_versions! if crop_x.present?
    end
    
    def self.incidents
    	Photo.uniq.pluck(:incidentName).compact.sort
    end

end
