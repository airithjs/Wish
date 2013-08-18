class Log < ActiveRecord::Base
	def self.add(content_id,rev,comment,editor)
		log = Log.new({content_id: content_id, rev: rev, comment: comment, editor: editor})
		log.save
	end
end
