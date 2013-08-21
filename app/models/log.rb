class Log < ActiveRecord::Base
	def self.add(content_id,comment)
		log = Log.new({content_id: content_id, comment: comment, editor: User.current})
		log.save
	end

	def self.delete_nil_id
		Log.where(content_id: nil).remove_all
	end

	def self.update_nil_id(id)
		Log.where(content_id: nil).update_all(content_id: id)
	end
end
