class WikiController < ApplicationController
	before_filter :authenticate_user! , :except => [:index, :view]

	def index
		@list = ContentInfo.all
	end

	def edit
		content_id = params[:content_id]
		@wiki = Wiki.get_last(content_id)
		@info = ContentInfo.get_or_new(content_id, params[:info])
		@task = Task.get_or_new(content_id)
		@parent = ( params[:info].nil? || params[:info][:parent].nil? || params[:info][:parent].to_i == 0) ? nil : ContentInfo.find(params[:info][:parent].to_i)

		if( params[:commit] == "save")
			@info.last_rev += 1
			@info.save!
			Wiki.update(@info.id, current_user.username, params[:text])
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
			Log.add(@info.id,@info.last_rev,params[:comment], current_user.username)
			redirect_to action: 'index'
		end
	end

	def images
		@images = RawFile.where("upload_content_type like ?", "image%").limit(10)
		render layout: nil
	end

	def upload
		params[:uploader] = current_user.username
		rf = RawFile.new(upload_params)
		rf.save
		redirect_to :back
	end

	def update_todo
		content_id = params[:content_id]
		idx = params[:idx]
		state = params[:state]
		result = ToDo.change_state(content_id,idx, state)
		t = Task.where(content_id: content_id).first
		t.finish_todo += (state != "new") ? 1 : -1
		t.save

		Log.add(content_id,0,"ch",current_user.username)

		render :json => result
	end

	def view
		content_id = params[:content_id]
		@info = ContentInfo.find(content_id)
		@wiki = Wiki.get_last(content_id)
	end

	def fragment
    @content_id = params[:content_id]
    @info = ContentInfo.find(@content_id)
    @wiki = Wiki.get_last(@content_id)
    render layout: nil
	end

	def history
		content_id = params[:content_id]
		@info = ContentInfo.find(content_id)
		@history = Wiki.where(content_id: content_id).order("rev DESC")
	end

	def log
		content_id = params[:content_id]
		@info = ContentInfo.find(content_id)
		@log = Log.where(content_id: content_id).order("rev DESC")
	end
end
