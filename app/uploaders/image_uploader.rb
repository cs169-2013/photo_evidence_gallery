# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  include Sprockets::Rails::Helper
  storage :fog
  include CarrierWave::MimeTypes
  process :set_content_type
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb, :from_version => :cropped_rotated do
    resize_to_fill(100, 100)
  end

  version :large do    
    resize_to_limit(600, 600)
  end

  version :rotated do
    process :rotate
    resize_to_limit(600,600)
  end

  version :cropped_rotated, :from_version => :rotated  do
    process :crop
    resize_to_limit(600,600)
  end

  def rotate
    if model.rotation.present?
      resize_to_limit(600, 600)
      manipulate! do |img|
        img.rotate!(model.rotation.to_i)
      end
    end
  end

  def crop
    if model.crop_x.present?
      resize_to_limit(600, 600)
      manipulate! do |img|
        x = model.crop_x.to_i
        y = model.crop_y.to_i
        w = model.crop_w.to_i
        h = model.crop_h.to_i
        img.crop!(x, y, w, h)
        img.rotate!(model.rotation.to_i)
      end
    end
  end
end
