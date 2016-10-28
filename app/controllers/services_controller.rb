class ServicesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :verify_slug, only: [:show, :edit, :update]


  # TODO: fix seeds and add to readme!
  def index
    @services = Service.all
  end

  def new
    # TODO: check if user is an admin
    @service = Service.new
  end

  def create
    # TODO: check if user is an admin
    @service = Service.new(service_params)
    binding.pry
    if @service.save
      redirect_to @service, notice: 'Your new service has been created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
    # TODO: check if user is an admin
  end

  def update
    # TODO: check if user is an admin
    if @service.save
      redirect_to @service, notice: 'Your new service has been created.'
    else
      render :new
    end
  end

  private
    def verify_slug
      @service ||= Service.find_by_slug(params[:id])
      if @service.blank?
        # TODO: change flash message
        redirect_to services_path, notice: 'The service you were looking for could not be found.'
      end
    end

    def service_params
      params.require(:service).permit(:service_name, :description, :price, :get_service_start, :get_service_end)
    end

end
