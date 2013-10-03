json.array!(@photos) do |photo|
  json.extract! photo, :caption, :tags, :incidentName, :operationalPeriod, :teamNumber, :contentType, :filename, :binaryData
  json.url photo_url(photo, format: :json)
end