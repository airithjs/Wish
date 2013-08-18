class Task < ActiveRecord::Base
	belongs_to :content_info
	def self.update(content_id, params)
		task = Task.where(content_id: content_id).first
		if( task.nil? )
			task = Task.new
			task.content_id = content_id
		end
		task.s_date = params[:s_date]
		task.e_date = params[:e_date]
		task
	end

	def self.get_or_new(content_id)
		task = Task.where(content_id: content_id).first || Task.new
		task
	end

	def completeness
		(100 * finish_todo/total_todo).to_i
	end

	def term
		total = (e_date.to_date - s_date.to_date).to_i
		return (total == 0) ? 100 : (100 * (Date.today - s_date.to_date)/total).to_i
	end
end
