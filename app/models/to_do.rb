class ToDo < ActiveRecord::Base
	STATE=[:new,:complete,:fail,:cancel]
	def self.add(content_id,idx,title)
		return false if( title.nil? || title.empty? )
		td = ToDo.new
		td.content_id = content_id
		td.idx = idx
		td.title = title
		td.state = 0
		td.save

		Log.add(content_id,"ToDo NEW : #{title}")
		return true
	end

	def self.change_state(content_id,idx,state)
		td = ToDo.where(content_id: content_id, idx: idx).first
		puts "STATE" + state
		return false if( td.nil? )
		td.state = STATE.index(state.to_sym) || state
		Log.add(content_id,"ToDo #{state} : #{td.title}")
		td.save
		return true
	end

	def state_str
		STATE[state]
	end
end
