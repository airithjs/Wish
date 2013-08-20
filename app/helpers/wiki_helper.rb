module WikiHelper
	def markdown(content)
  	@markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true, fenced_code_blocks: true)
  	@markdown.render(content)
	end

	def convert(text)
		text.gsub!(/\[\[(.+)\]\]/){|m| wiki_syn($1) }
		lines = text.split(/\r\n/)
		result = []
		state = nil
		code_language = nil
		buffer = []
		for i in lines
			if( state == nil)
				case i
				when /^sub> (.+)/ then
					result << closer(state,buffer,code_language)
					result << "<div class='div_fragment unload' content_id='#{$1}'>#{$1}</div>"
					buffer = []
				when /^code:(.+)>/ then 
					result << closer(state,buffer,code_language)
					state = :code
					code_language = $1
					buffer = []
				when /^([^\/\s]+)>/ then
					result << closer(state,buffer,code_language)
					state = $1.to_sym
					buffer = []
				else 
					buffer << i
				end
			elsif( i =~ /\/(.+)>/ )
				flag = $1
				if( flag.to_sym == state)
					result << closer(state,buffer,code_language)
					buffer = []
					state = nil
				else
					buffer << i
				end
			else
				buffer << i
			end
		end
		result << closer(state,buffer,code_language)
		result.join("<br/>").html_safe
	end

	def closer(state, buffer, lang_type)
		return nil if( buffer.size <= 0)
		case state
		when :table then 
			"<table class='table_default'>" + 
			buffer.map{|i| "<tr>" + i.split(/[\t|]/).map{|d| (d =~ /^_/) ? "<th>#{d.sub(/^_/,"")}</td>" : "<td>#{d}</td>" }.join("") +"</td></tr>" }.join("\r\n") + 
			"</table>"
		when :pre  then 
			"<pre>" + buffer.join("\r\n") + "</pre>"
		when :code then 
			"<div class='div_code CodeRay' language='#{lang_type}'>" + buffer.map{|i| CodeRay.scan(i, lang_type.to_sym).html.sub(/^( +)/){|s| "&nbsp;" * s.size}}.join("<br/>")  + "</div>"
		else
			markdown(buffer.join("\r\n"))
		end
	end

	def wiki_syn(text)
		fields = text.split(/\|/)
		puts "Fields : #{fields}"
		case fields.first
		when "img" then
			hash = {}
			url = ""
			fields.each do |f|
				(k,v) = f.split(/\:/)
				if( k == "id")
					rf = RawFile.where(id: v.to_i).first
					url = (rf.nil?) ? v : rf.upload.url(:original)
				elsif( k == "url")
					url = v
				else
					hash[k] = v
				end
			end
			return image_tag url, hash
		else
			return "[[Not Match]]"
		end
	end
end
