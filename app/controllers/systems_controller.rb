class SystemsController < ApplicationController
  before_action :set_system, only: [:show, :edit, :update, :destroy]
  #layout "systems"

  #######################################################################################
  # GET /systems
  # GET /systems.json
  #######################################################################################
  def index


    @systems = System.all

    respond_to do |format|
      format.html # index.html.erb
      @system = @systems[0]
      #puts "First system id: " + @system.id.to_s
      format.json { render json: @systems }
    end

  end

  #######################################################################################
  # GET /systems/1
  # GET /systems/1.json
  #######################################################################################
  def show

    #@system = System.find(params[:id])
    set_system
    respond_to do |format|
      #format.html # show.html.erb
      format.js {}
      format.json { render json: @system }
    end


  end

  #######################################################################################
  # GET /systems/new
  #######################################################################################
  def new

    @system = System.new
    #@appliance = Appliance.new
    #@system.appliances.build

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @system }
    end

  end

  #######################################################################################
  # GET /systems/1/edit
  #######################################################################################
  def edit
    puts "System Id: " + params[:id].to_s
    @system = System.find(params[:id])
    respond_to do |format|
      #format.html # new.html.erb
      format.js 
      format.json { render json: @system }
    end

  end

  #######################################################################################
  # POST /systems
  # POST /systems.json
  #######################################################################################
  def create

    @system = System.new(system_params)

    respond_to do |format|
      if @system.save
        format.html { redirect_to @system, notice: 'System was successfully created.' }
        format.js { render :show }
        format.json { render json: @system, status: :created, location: @system }
      else
        format.html { render action: "new" }
        format.json { render json: @system.errors, status: :unprocessable_entity }
      end
    end

  end

#######################################################################################
  # PATCH/PUT /systems/1
  # PATCH/PUT /systems/1.json
#######################################################################################
  def update
    respond_to do |format|
      if @system.update(system_params)
        format.html { redirect_to @system, notice: 'System was successfully updated.' }
        format.js { render :show }
        format.json { render :show, status: :ok, location: @system }
      else
        format.html { render :edit }
        format.json { render json: @system.errors, status: :unprocessable_entity }
      end
    end
  end

#######################################################################################
  # DELETE /systems/1
  # DELETE /systems/1.json
#######################################################################################
  def destroy
    @system = System.find(params[:id])
    @system.destroy
    redirect_to systems_path
    # @systems = System.all

    # respond_to do |format|
    #   format.html # index.html.erb
    #   @system = @systems[0]
    #   #puts "First system id: " + @system.id.to_s
    #   format.json { render json: @systems }
    # end
    # respond_to do |format|
    #   format.html { redirect_to @system, notice: 'System was successfully updated.' }
    #   format.js { render :show }
    #   format.json { render :show, status: :ok, location: @system }
    # end
  end

#######################################################################################
# private methods
#######################################################################################
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system
      @system = System.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def system_params
      #params[:system]
      params.require(:system).permit(:name, :system_type, :purpose, :status)
    end
    # def appliance_params
    #   params.require(:appliance).permit(:host_name, :ip_addr, :license, :machinesig, :port, :assigned_to, :assigned_from, :assigned_til, :system_id)
    # end
    # def cpu_params
    #   params.require(:appliance).permit(:chip, :cores, :frequency, :threads)
    # end
end
