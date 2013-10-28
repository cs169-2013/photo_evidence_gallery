CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    :provider               => 'AWS',                       # required
    :aws_access_key_id      => 'AKIAJEXL5HZ4SJD6NXEA',    # required
    :aws_secret_access_key  => '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'     # required
  }
  config.fog_directory  = 'chrishsu2312testbucket'         # required
end
