module PoolConfigurationsHelper
	def get_appliance_pool_configs(appliance_id)
		pool_configs = PoolConfiguration.where(appliance_id: appliance_id)		#.pluck(:name, :redundancy, :max_devices, :, :used_bay_count)
		return pool_configs
	end

	def get_pool_size(redundancy, max_devices, disk_size, vdev_size)
		disk_size = "2".to_i

		case redundancy
		when "mirror"
			pool_size = disk_size * max_devices/2
		when "raidz1"
			pool_size = disk_size * (max_devices - (max_devices/vdev_size))
		when "raidz2"
			pool_size = disk_size * (max_devices - (max_devices/vdev_size))
		when "raidz3"
			pool_size = disk_size * (max_devices - (max_devices/vdev_size))
		when "stripe"
			pool_size = disk_size * max_devices
		else 
			pool_size = "N/A"
		end
	end
end
