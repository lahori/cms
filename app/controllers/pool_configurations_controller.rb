class PoolConfigurationsController < ApplicationController
  #before_action :set_pool_configuration, only: [:show, :edit, :update, :destroy]

  # GET /pool_configurations
  # GET /pool_configurations.json
  def index
    @pool_configurations = PoolConfiguration.all
    respond_to do |format|
      #format.html
      format.js
      format.json { render json: @pool_configurations }
    end
  end

  # GET /pool_configurations/1
  # GET /pool_configurations/1.json
  def show

    Rails.logger.debug("Inspecting PARAMS ------------->")
    Rails.logger.debug params.inspect
    Rails.logger.debug("Done Inspecting PARAMS <-------------")
    
    @pool_configuration = PoolConfiguration.find(params[:id])
    respond_to do |format|
      #format.html
      format.js
      format.json { render json: @pool_configuration }
    end
  end

  # GET /pool_configurations/new
  def new
    @pool_configuration = PoolConfiguration.new

    @pool_configuration.appliance_id = params[:appliance_id]
    # Rails.logger.debug("*******************************************")
    # Rails.logger.debug("New Pool Config: #{@pool_configuration.inspect}")
    
    respond_to do |format|
      #format.html
      format.js
      format.json { render json: @pool_configuration }
    end
  end

  # GET /pool_configurations/1/edit
  def edit
  end

  # POST /pool_configurations
  # POST /pool_configurations.json
  def create
    @pool_configuration = PoolConfiguration.new(pool_configuration_params)
    #@pool_configuration.validate!
    #Rails.logger.debug params.inspect
    #Rails.logger.debug("*******************************************")
    #Rails.logger.debug("Appliance: #{@pool_configuration.inspect}")
    #Rails.logger.debug("Appliance Id: " + params[:appliance_id].to_s)
    @pool_configuration.appliance_id = params[:appliance_id].to_i
    # @pc = PoolConfiguration.new
    # @pool_configuration.name = "MyConfig"
    # @pool_configuration.redundancy = "Mirror"
    # @pool_configuration.max_devices = "20"
    # @pool_configuration.vdev_size = "2"
    #@pool_configuration.media_type = 'hdd'
    #@pool_configuration.disk_size = '1TB'
    #@pool_configuration.enclosures = 'abc,def'
    #@pool_configuration.enclosure_redundancy = "true"
    #@pool_configuration.force = "true"
    #@pool_configuration.appliance_id = 1

    respond_to do |format|
      #if @pool_configuration.create!
      if @pool_configuration.save
        format.js { render :show }
        #format.html { redirect_to @pool_configuration, notice: 'Pool configuration was successfully created.' }
        #format.json { render :show, status: :created, location: @pool_configuration }
      else
        Rails.logger.debug("Pool Save Error: " + @pool_configuration.errors.full_messages.to_s)
        format.html { render :new }
        format.json { render json: @pool_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pool_configurations/1
  # PATCH/PUT /pool_configurations/1.json
  def update
    respond_to do |format|
      if @pool_configuration.update(pool_configuration_params)
        format.html { redirect_to @pool_configuration, notice: 'Pool configuration was successfully updated.' }
        format.json { render :show, status: :ok, location: @pool_configuration }
      else
        format.html { render :edit }
        format.json { render json: @pool_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pool_configurations/1
  # DELETE /pool_configurations/1.json
  def destroy
    @pool_configuration.destroy
    respond_to do |format|
      format.html { redirect_to pool_configurations_url, notice: 'Pool configuration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_pool_config
    Rails.logger.debug("Inspecting PARAMS ------------->")
    Rails.logger.debug params.inspect
    Rails.logger.debug("Done Inspecting PARAMS <-------------")
    @pool_config = PoolConfiguration.where("name = :config_name AND appliance_id = :id",
      {config_name: params[:name], id: params[:appliance_id]}).limit(1)
    respond_to do |format|
      #format.html
      format.js
      format.json { render json: @pool_config }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pool_configuration
      @pool_configuration = PoolConfiguration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pool_configuration_params
      params.fetch(:pool_configuration, {}).permit!
      #params.require(:pool_configuration).permit!
      #params.require(:pool_configuration).permit(:name,:redundancy,:max_devices,:vdev_size,:media_type,:disk_size,:enclosures,:enclosure_redundancy,:force,:appliance_id)
    end
end
