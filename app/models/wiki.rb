class Wiki < ActiveRecord::Base
	def self.update(content_id, editor, text)
		new_wiki = Wiki.new
		new_wiki.text = text
		new_wiki.content_id = content_id
		new_wiki.editor = editor

		old_wiki = Wiki.where(content_id: content_id).order("rev DESC").first

		if( old_wiki )
			new_wiki.rev = old_wiki.rev
			old_wiki.is_last = false
			old_wiki.save
		end
		new_wiki.rev += 1
		new_wiki.save!

		new_wiki
	end

	def self.get_last(content_id)
		Wiki.where(content_id: content_id).order("rev DESC").first || Wiki.new
	end
end
