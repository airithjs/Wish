class AttentionContent < ActiveRecord::Base
	has_one :content_info, :foreign_key => "id"
	STATE=["reader","person", "manager", "admin"]

	def self.get(content_id,userid)
		ac = AttentionContent.where(content_id: content_id, userid: userid).first 
		if( ac.nil? )
			ac = AttentionContent.new
			ac.userid = userid
			ac.content_id = content_id
		end
		ac
	end

	def self.manager(content_id,userid)
		ac = AttentionContent.get(content_id,userid)
		ac.attention_type = 3 
		ac.save
	end

	def self.person(content_id,userid)
		ac = AttentionContent.get(content_id,userid)
		ac.attention_type = 2 if( ac.attention_type <= 2)
		ac.save
	end

	def self.reader(content_id,userid)
		ac = AttentionContent.get(content_id,userid)
		ac.attention_type = 1 if( ac.attention_type <= 1 )
		ac.save
	end
end
