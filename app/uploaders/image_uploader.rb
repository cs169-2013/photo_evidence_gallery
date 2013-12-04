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
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}/#{model.created_at}"
  end

  process :crop
  process :rotate 
  resize_to_limit(600, 600)

  version :thumb do
    process :shrink
  end

  def rotate
    if model.rotation.present?
      resize_to_limit(600, 600)
      manipulate! do |img|
        img.rotate!(model.rotation.to_i)
      end
    end
  end

  def shrink
    manipulate! do |img|
      img.scale!(100, 100)
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
      end
    end
  end
end
