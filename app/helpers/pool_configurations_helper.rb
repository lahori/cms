module PoolConfigurationsHelper
	def get_appliance_pool_configs(appliance_id)
		return PoolConfiguration.find_by appliance_id: appliance_id
	end

end
