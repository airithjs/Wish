class Task < ActiveRecord::Base
	belongs_to :content_info
	def self.update(content_id, params = nil)
		task = Task.where(content_id: content_id).first
		if( task.nil? )
			task = Task.new
			task.content_id = content_id
		end
		task.total_todo = ToDo.where(content_id: content_id).size
		task.finish_todo = ToDo.where("content_id = ? AND state > 0", content_id).size

		unless(params.nil?)
			task.s_date = params[:s_date]
			task.e_date = params[:e_date]
			task.person = params[:person]
			AttentionContent.person(content_id,task.person)
		end
		
		Log.add(content_id,"Task with #{task.finish_todo}/#{task.total_todo} todo")
		task.save
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
