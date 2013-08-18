class ContentInfo < ActiveRecord::Base
	has_one :task, :foreign_key => "content_id"
	has_many :to_do, :foreign_key => "content_id"
	has_many :sub, :class_name => "ContentInfo", :foreign_key => "parent"
	
	CONTENT_TYPE=[:wiki, :project, :task]

	def self.content_type_list
		CONTENT_TYPE
	end

	def self.create(params)
		ci = ContentInfo.new
		unless( params.nil? )
			ci.title = params[:title] || ""
			ci.tag = params[:tag] || ""
			ci.category = params[:category] || ""
			ci.content_type = params[:content_type] || :wiki
			ci.parent = params[:parent] || nil
		end
		ci
	end
end
