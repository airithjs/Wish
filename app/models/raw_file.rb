class RawFile < ActiveRecord::Base
  has_attached_file :upload,
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"

  def self.add(params)
  	rf = RawFile.new(params)
  	rf.uploader = User.current
  	Log.add(rf.content_id,"File NEW : #{rf.upload_file_name}")
  	rf.save
  	return true
  end

  def self.delete_nil_id
  	RawFile.where(content_id: nil).remove_all
  end

  def self.update_nil_id(id)
  	RawFile.where(content_id: nil).update_all(content_id: id)
  end
end
