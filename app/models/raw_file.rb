class RawFile < ActiveRecord::Base
  has_attached_file :upload,
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"
end
