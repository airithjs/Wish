class Project < ActiveRecord::Base
	belongs_to :content_info

	def self.update(content_id, params = nil)
		project = Project.where(content_id: content_id).first
		if( project.nil? )
			project = Project.new
			project.content_id = content_id
		end
		unless( params.nil?)
			project.manager = params[:manager]
		end
		project.save
	end
end
