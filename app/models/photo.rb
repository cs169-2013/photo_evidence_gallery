require 'date'

class Photo < ActiveRecord::Base

  mount_uploader :image, ImageUploader
  after_save :extract_metadata, :enqueue_image
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :rotation


  def extract_metadata
    return if @img
    return unless image_exists?

    @img = Magick::Image.read(image)[0] rescue nil
    return unless @img
    img_lat = exif_extractor('GPSLatitude', true)
    img_lng = exif_extractor('GPSLongitude', true)

    lat_ref = exif_extractor('GPSLatitudeRef', false)
    lng_ref = exif_extractor('GPSLongitudeRef', false)
    return unless img_lat && img_lng && lat_ref && lng_ref

    if self.time_taken.blank?
      self.time_taken = exif_extractor('DateTime', false)
    end


    latitude = coordinate(img_lat)
    longitude = coordinate(img_lng)

    latitude = latitude * -1 if lat_ref == 'S'  # (N is +, S is -)
    longitude = longitude * -1 if lng_ref == 'W'   # (W is -, E is +)

    self.lat = latitude
    self.lng = longitude
    save!

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

  def rotate_image
    image.recreate_versions! if rotation.present?
  end

  def self.incidents
    Photo.uniq.pluck(:incident_name).compact.sort.delete_if{|x| x == ""}
  end
	
	def nullify_rotate_and_crop
        rotation = nil
		    crop_x = nil
        crop_y = nil
        crop_w = nil
        crop_h = nil
	end

  def enqueue_image
    ImageWorker.perform_async(id, key) if key.present?
  end

  class ImageWorker
    include Sidekiq::Worker
    
    def perform(id, key)
      photo = Photo.find(id)
      photo.key = key
      photo.remote_image_url = photo.image.direct_fog_url(with_path: true)
      photo.save!
    end
  end
end
