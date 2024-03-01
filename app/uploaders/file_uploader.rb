class FileUploader < CarrierWave::Uploader::Base

  storage :grid_fs

end
