require_relative 'url_shorteners'
require 'active_support/inflector'
module MultiShorten
	# Client class for MultiShorten
	# initialize the client with 
	# client = MultiShorten::Client.new
	class Client
		# The only method required to use all the features
		# @param [Hash] params hash with all the required parameters
		# @return [Hash] the result hash with status and if successful, the shortened url as well. 
		def shorten params
			raise "Parameter should be a hash" unless params.is_a?(Hash)
			return missing_parameter_error(:url) if params[:url].nil?
			return missing_parameter_error(:mode) if params[:mode].nil?
			case params[:mode]
			when "single"
				return missing_parameter_error(:shortener) if params[:shortener].nil?
				single(params[:shortener], params[:url])
			when "multiple"
				return missing_parameter_error(:shorteners) if params[:shorteners].nil
				multiple(params[:shorteners], params[:url])
			end
		end

		private

		def single shortener, url
			"MultiShorten::#{shortener.camelize}".constantize.shorten(url) rescue fail
		end

		def multiple shorteners, url
			result = {}
			shorteners.each do |shortener|
				result[shortener] = single(shortener, url)
			end
			result
		end

		def missing_parameter_error param
			raise "Missing required parameter: #{param}"
		end

		def fail
			{:status => :fail}
		end
	end

end
