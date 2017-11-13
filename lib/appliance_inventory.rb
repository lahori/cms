require 'cms_rest'
require 'json'

class ApplianceInventory
	include CMSRest

	attr_accessor :token
	attr_accessor :url

	def initialize (payload, appliance_url)
		
		@url = appliance_url
		CMSRest.url(@url)
		uri = "/auth/login"
		response = CMSRest.get_token(uri, payload)
		@token = response["token"]
		# rest_client = CMSRest::Client.new(uri, "root", "plusultra")
		# response = RestClient::Request.execute(	method: :post,
		# 																				url: 'https://10.16.104.11:8443/auth/login',
		# 																				payload: {"username" => "admin", "password" => "Nexenta@1"}.to_json,
		# 																				:verify_ssl => false,
		# 																				:headers => {'Content-Type' => 'application/json'}
		# 																			)

		# @token = JSON.parse(response)["token"]

		# response = @client.send_post('auth/login', { :username => 'root', :password => 'plusultra' }, @token)
	
	end

	def get_appliance_details
		memory
		hbas
		cpus
		enclosures
		disks
		nics
	end

	def memory
		uri = "inventory/memory"
		response = CMSRest.send_get(uri, @token)
	end

	def hbas
		uri = "inventory/hbas"
		response = CMSRest.send_get(uri, @token)
	end

	def cpus
		uri = "inventory/cpus"
		response = CMSRest.send_get(uri, @token)
		# (CMSRest.send_get(uri, @token)).each do |cpu|
		# 	Rails.logger.debug(cpu['model'])
		# end
	end

	def enclosures
		uri = "inventory/enclosures"
		response = CMSRest.send_get(uri, @token)
	end

	def disks
		uri = "inventory/disks"
		response = CMSRest.send_get(uri, @token)
	end

	def nics
		uri = "inventory/nics"
		response = CMSRest.send_get(uri, @token)
	end

end