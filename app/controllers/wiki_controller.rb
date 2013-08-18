class WikiController < ApplicationController
	def index
		@list = ContentInfo.all
	end

	def edit
		content_id = params[:content_id]
		@wiki = Wiki.get_last(content_id)
		if( content_id.nil? || content_id.empty? )
			@info = ContentInfo.create(params[:info])  
		else
			@info = ContentInfo.find(content_id)
		end
		@task = Task.get_or_new(content_id)

		if( params[:commit] == "save")
			@info.last_rev += 1
			@info.save!
			Wiki.update(@info.id, "tester", params[:text])
			if( @info.content_type == "task" )
				task = Task.update(@info.id,params[:task])
				params[:todo].each do |k,v| 
					if( v != "")
						ToDo.add(@info.id,k,v)
						task.total_todo += 1
					end
				end
				task.save
			end
			redirect_to action: 'index'
		end
	end

	def update_todo
		content_id = params[:content_id]
		idx = params[:idx]
		state = params[:state]
		result = ToDo.change_state(content_id,idx, state)
		t = Task.where(content_id: content_id).first
		t.finish_todo += (state != "new") ? 1 : -1
		t.save

		render :json => result
	end

	def view
		content_id = params[:content_id]
		@info = ContentInfo.find(content_id)
		@wiki = Wiki.get_last(content_id)
	end

	def history
		content_id = params[:content_id]
		@info = ContentInfo.find(content_id)
		@history = Wiki.where(content_id: content_id).order("rev DESC")
	end
end
