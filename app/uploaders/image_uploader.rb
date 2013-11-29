# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include CarrierWaveDirect::Uploader

  include Sprockets::Rails::Helper
  include CarrierWave::MimeTypes
  process :set_content_type

  process :crop
  process :rotate 
  resize_to_limit(600, 600)

  version :thumb do
    resize_to_fill(100, 100)
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
      end
    end
  end
end
