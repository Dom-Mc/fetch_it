class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update]

  def index
    @services = Service.all
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    if @service.save
      redirect_to @service, notice: 'Your new service has been created.'
    else
      render :new
    end
  end

  def show
    # @service = Service.find(params[:id])
  end

  def edit
    # @service = Service.find(params[:id])
  end

  def update
    if @service.save
      redirect_to @service, notice: 'Your new service has been created.'
    else
      render :new
    end
  end

  private
    def set_service
      @service = Service.find(params[:id])
    end

    def service_params
      params.require(:service).permit(:service_name, :description, :price, :start_time, :end_time, :start_at)
    end

end
