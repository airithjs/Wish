class ContentInfo < ActiveRecord::Base
	has_one :task, :foreign_key => "content_id"
	has_many :to_do, :foreign_key => "content_id"
	has_many :sub, :class_name => "ContentInfo", :foreign_key => "parent"
	
	CONTENT_TYPE=[:wiki, :project, :task]

	def self.content_type_list
		CONTENT_TYPE
	end

	def self.get_or_new(content_id, params)
		ci = ContentInfo.where(id: content_id).first || ContentInfo.new
		unless( params.nil? )
			ci.title = params[:title] || ""
			ci.tag = params[:tag] || ""
			ci.category = params[:category] || ""
			ci.content_type = params[:content_type] || :wiki
			ci.parent = params[:parent] || nil
		end
		ci
	end

	def total_task
		sum = 0
		unless( task.nil? )
			sum = task.total_todo
			sub.each do |i|
				unless( i.task.nil? )
					sum += i.task.total_todo
				end
			end
		end
		sum
	end

	def finish_task
		sum = 0
		unless( task.nil? )
			sum = task.finish_todo
			sub.each do |i|
				unless( i.task.nil? )
					sum += i.task.finish_todo
				end
			end
		end
		sum
	end

	def completeness
		(100 * finish_task / total_task).to_i
	end
end
