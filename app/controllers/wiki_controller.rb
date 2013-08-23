class WikiController < ApplicationController
	before_filter :authenticate_user! , :except => [:index, :view]
	before_filter :set_current_user

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
			Log.delete_nil_id
			RawFile.delete_nil_id
			@info.last_rev += 1
			@info.save!
			Wiki.update(@info.id, params[:comment], params[:text])
			if( @info.content_type == "task" )
				params[:todo].each do |k,v| 
					if( v != "")
						ToDo.add(@info.id,k,v)
					end
				end
				Task.update(@info.id,params[:task])
			elsif( @info.content_type == "project" )
				Project.update(@info.id,params[:project])
			end
			Log.update_nil_id(@info.id)
			RawFile.update_nil_id(@info.id)
			redirect_to action: 'view', content_id: @info.id
		end
	end



	def upload
		RawFile.add(upload_params)
		redirect_to :back
	end

	def update_todo
		content_id = params[:content_id]
		idx = params[:idx]
		state = params[:state]
		ToDo.change_state(content_id, idx, state)
		Task.update(content_id)
		render :json => result
	end

	def images
		@images = RawFile.where("upload_content_type like ?", "image%").limit(10)
		render layout: nil
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
		@log = Log.where(content_id: content_id).order("updated_at DESC")
	end
end
