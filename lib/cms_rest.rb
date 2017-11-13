require 'net/http'
require 'net/https'
require 'uri'
require 'json'

module CMSRest

		attr_accessor :url

		def CMSRest.url(url)
			@url = url
		end
		
		def CMSRest.get_token(uri, data)
			return (CMSRest.send_request('POST', uri, data, nil))
		end

		def CMSRest.send_get(uri, token) 
			CMSRest.send_request('GET', uri, nil, token)
		end

		def CMSRest.send_post(uri, data, token)
			CMSRest.send_request('POST', uri, data, token)
		end

		def CMSRest.send_request(method, uri, data, token)
			url = URI.parse(@url + uri)
			puts "Full URL: => " + url.to_s
			if method == 'POST'
				#puts url.path.to_s
				#puts url.query.to_s
				request = Net::HTTP::Post.new(url.path)
				request.body = JSON.dump(data)
				#puts request.body.to_s
			else
				puts "URL Path: " + url.path.to_s
				request = Net::HTTP::Get.new(url.path)
			end
			request.add_field("Content-Type", "application/json")
			if uri != "auth/login" 
				request.add_field("Authorization", "Bearer #{token}")
			end
			#request.add_field("Authorization", "Bearer #{token}")

			puts "URL Host: " + url.host.to_s
			puts "URL Port: " + url.port.to_s
			conn = Net::HTTP.new(url.host, url.port)
			if url.scheme == 'https'
				conn.use_ssl = true
				conn.verify_mode = OpenSSL::SSL::VERIFY_NONE
			end
			response = conn.request(request)

			if response.body && !response.body.empty?
				result = JSON.parse(response.body)
			else
				result = {}
			end
			#puts response.code.to_s
			if response.code != '200'
				if result && result.key?('error')
					error = '"' + result['error'] + '"'
				else
					error = 'No additional error message received'
				end
				raise APIError.new('NEF API returned HTTP %s (%s)' %
					[response.code, error])
			end
			
			result
		end

	class APIError < StandardError
	end
end