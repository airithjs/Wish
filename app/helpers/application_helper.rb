module ApplicationHelper
	def convert(text)
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
					result << "<div class='div_fragment unload' title='#{$1}'>#{$1}</div>"
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
		result.join("\r\n").html_safe
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

	def markdown(content)
  	@markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true, fenced_code_blocks: true)
  	@markdown.render(content)
	end

	def image_url(raw_file)
		image_tag i.upload.url(:original)
	end
end
