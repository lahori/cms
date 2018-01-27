class PoolConfigurationsController < ApplicationController
  before_action :set_pool_configuration, only: [:show, :edit, :update, :destroy]

  # GET /pool_configurations
  # GET /pool_configurations.json
  def index
    @pool_configurations = PoolConfiguration.all
  end

  # GET /pool_configurations/1
  # GET /pool_configurations/1.json
  def show
  end

  # GET /pool_configurations/new
  def new
    @pool_configuration = PoolConfiguration.new
    respond_to do |format|
      format.html
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

    respond_to do |format|
      if @pool_configuration.save
        format.html { redirect_to @pool_configuration, notice: 'Pool configuration was successfully created.' }
        format.json { render :show, status: :created, location: @pool_configuration }
      else
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pool_configuration
      @pool_configuration = PoolConfiguration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pool_configuration_params
      params.fetch(:pool_configuration, {})
    end
end
