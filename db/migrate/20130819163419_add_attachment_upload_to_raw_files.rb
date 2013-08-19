class AddAttachmentUploadToRawFiles < ActiveRecord::Migration
  def self.up
    change_table :raw_files do |t|
      t.attachment :upload
    end
  end

  def self.down
    drop_attached_file :raw_files, :upload
  end
end
