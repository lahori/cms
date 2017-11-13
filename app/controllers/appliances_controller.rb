class AppliancesController < ApplicationController

  require 'appliance_inventory'
  
  # GET /appliances
  # GET /appliances.json
  def index
    puts "In Appliance Controller -> Action -> index"
    @appliances = Appliance.all

  end

  #######################################################################################
  # GET /appliances/1
  # GET /appliances/1.json
  #######################################################################################
  def show
   
    system = System.find(params[:system_id])
    @system_id = system.id
    
    @appliances = system.appliances

    respond_to do |format|
      #format.html # show.html.erb
      format.js
      #format.json { render json: @system }
    end
  end

  #######################################################################################
  # GET /appliances/new
  #######################################################################################
  def new
    @appliance = Appliance.new
    @appliance.system_id = params[:system_id]
    respond_to do |format|
      format.html
      format.js
      format.json { render json: @appliance }
    end
  end

  #######################################################################################
  # GET /appliances/1/edit
  #######################################################################################
  def edit
  end

  #######################################################################################
  # POST /appliances
  # POST /appliances.json
  #######################################################################################
  def create
    @appliance = Appliance.new(appliance_params)
    #Rails.logger.debug("Appliance: #{@appliance.inspect}")
    
    ## Get Appliance Details (inventory) using REST connection provided in appliance_params
    #payload = {"username" => "root", "password" => "plusultra"}
    credentials = {"username" => @appliance.user_name, "password" => @appliance.password}
    appliance_inventory = ApplianceInventory.new(credentials, @appliance.url)
    memory = appliance_inventory.memory['data']
    hbas = appliance_inventory.hbas['data']
    cpus = appliance_inventory.cpus['data']
    enclosures = appliance_inventory.enclosures['data']
    disks = appliance_inventory.disks['data']
    nics = appliance_inventory.nics['data']
    # Rails.logger.debug("Appliance: " + appliance_inventory.token.to_s)
    # Rails.logger.debug("Memory: " + @memory.to_s)
    # Rails.logger.debug("hba: " + hbas.to_s)
    #Rails.logger.debug("CPUs: " + cpus.to_s)
    #Rails.logger.debug("Enclosures: " + enclosures.to_s)
    # Rails.logger.debug("Disks: " + disks.to_s)
    # Rails.logger.debug("NICs: " + nics.to_s)
    @appliance.system_id = params[:system_id]
    respond_to do |format|
      if @appliance.save
        ## Save memory details
        save_hbas(hbas)    
        save_cpus(cpus)                             
        save_enclousres(enclosures)
        save_disks(disks)
        save_nics(nics)

        system = System.find(params[:system_id])
        @system_id = system.id
        @appliances = system.appliances
        #format.html { redirect_to @appliance, notice: 'Appliance was successfully created.' }
        format.js { render :show }
        #format.json { render json: @appliance, status: :created, location: @appliance }
      else
        format.html { render action: "new" }
        format.json { render json: @appliance.errors, status: :unprocessable_entity }
      end
    end
  end

  #######################################################################################
  # PATCH/PUT /appliances/1
  # PATCH/PUT /appliances/1.json
  #######################################################################################
  def update
    respond_to do |format|
      if @appliance.update(appliance_params)
        format.html { redirect_to @appliance, notice: 'Appliance was successfully updated.' }
        format.json { render :show, status: :ok, location: @appliance }
      else
        format.html { render :edit }
        format.json { render json: @appliance.errors, status: :unprocessable_entity }
      end
    end
  end

  #######################################################################################
  # DELETE /appliances/1
  # DELETE /appliances/1.json
  #######################################################################################
  def destroy
    @appliance = Appliance.find(params[:id])
    @system_id = @appliance.system_id
    @appliance.destroy
    system = System.find(@system_id)
    @appliances = system.appliances

    respond_to do |format|
      format.js { render :show }
      #format.html { redirect_to appliances_url, notice: 'Appliance was successfully destroyed.' }
      #format.json { head :no_content }
    end
  end

  #######################################################################################
  # GET /appliance/1
  #######################################################################################
  def details
    
    @appliance = Appliance.find(params[:id])
    
    @cpus = @appliance.cpus
    @hbas = @appliance.hbas
    @nics = @appliance.nics
    @disks = @appliance.disks
    @enclosures = @appliance.enclosures
    
    respond_to do |format|
      #format.html # show.html.erb
      format.js {}
      #format.json { render json: @system }
    end
  end

  #######################################################################################
  # Private methods
  #######################################################################################
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appliance
      @appliance = Appliance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appliance_params
      #params[:appliance]
      #params[:appliance].permit(:host_name, :ip_addr, :license, :machinesig, :port, :assigned_to, :assigned_from, :assigned_til, :system_id)
      params.require(:appliance).permit(:manufacturer, :model, :serial, :guid, :ip_addr, :user_name, :password, :url, :system_id)
    end

    def save_hbas (hbas)
      hbas.each do |hba|
        Rails.logger.debug(hba.to_s)
        Hba.create!(adapter_id: hba['adapterId'],
                    model: hba['model'],
                    product_id: hba['modelInfo']['productId'],
                    vendor_id: hba['modelInfo']['vendorId'],
                    adaptor_description: hba['modelInfo']['adapterDescription'],
                    hw_version: hba['modelInfo']['hwVersion'],
                    fw_version: hba['modelInfo']['fwVersion'],
                    driver_name: hba['driverName'],
                    driver_version: hba['driverVersion'],
                    lu_count: hba['luCount'],
                    port_count: hba['portCount'],
                    peer_count: hba['peerCount'],
                    appliance_id: @appliance.id)
      end
    end

    def save_enclousres (enclosures)
      enclosures.each do |enclosure|
        Rails.logger.debug(enclosure.to_s)
        Enclosure.create!(chasis_id: enclosure['chassisId'],
                          model: enclosure['model'],
                          product_id: enclosure['modelInfo']['productId'],
                          vendor_id: enclosure['modelInfo']['vendorId'],
                          revision: enclosure['modelInfo']['revision'],
                          total_bay_count: enclosure['totalBayCount'],
                          used_bay_count: enclosure['usedBayCount'],
                          serial_num: enclosure['unitSerial'],
                          appliance_id: @appliance.id)
        end
    end
    def save_disks (disks)
      disks.each do |disk|
        Rails.logger.debug(disk.to_s)
        Disk.create!( device_name: disk['devname'],
                      logical_device: disk['logicalDevice'],
                      model: disk['model'],
                      vendor_id: disk['modelInfo']['vendorId'],
                      product_id: disk['modelInfo']['productId'],
                      serial: disk['modelInfo']['serial'],
                      revision: disk['modelInfo']['revision'],
                      size: disk['size'],
                      media_type: disk['physical']['mediaType'],
                      interface: disk['physical']['interface'],
                      state: disk['state'],
                      location: disk['location'],
                      appliance_id: @appliance.id)
      end

    end
    def save_cpus (cpus)
      cpus.each do |cpu|
          Rails.logger.debug(cpu.to_s)
          Cpu.create!(chip_id: cpu['chipId'],
                      model: cpu['model'],
                      vendor_id: cpu['vendorId'],
                      cores: cpu['coreCount'],
                      frequency: cpu['frequency'],
                      threads: cpu['threadCount'],
                      appliance_id: @appliance.id)
        end
    end

    def save_nics (nics)
      nics.each do |nic|
          Rails.logger.debug(nic.to_s)
          Nic.create!(mac: nic['mac'],
                      media_type: nic['mediaType'],
                      name: nic['name'],
                      speed: nic['speed'],
                      duplex: nic['duplex'],
                      state: nic['state'],
                      appliance_id: @appliance.id)
        end  
    end
    def save_memory (memory)
    end

end
