module AppliancesHelper
	def getDistinctDisksCount(id)
		disks = Disk.where(appliance_id: id).group(:media_type,:size).count
		return disks
	end
	def getEnclosures(id)
		enclosures = Enclosure.where(appliance_id: id).pluck(:product_id, :vendor_id, :chasis_id, :total_bay_count, :used_bay_count)
		return enclosures
	end
end