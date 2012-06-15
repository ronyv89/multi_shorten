require_relative 'url_shorteners'
require 'active_support/inflector'
module MultiShorten
	class Client
		def shorten params
			return missing_parameter_error(:url) if params[:url].nil?
			return missing_parameter_error(:mode) if params[:mode].nil?
			case params[:mode]
			when single
				return missing_parameter_error(:shortener)
			end
		end

		

		private

		def single shortener, url
			"MultiShorten::#{shortener.camelize}".constantize.shorten(url) rescue fail
		end

		def missing_parameter_error param
			raise "Missing required parameter: #{param}"
		end

		def fail
			{:status => :fail}
		end
	end

end
