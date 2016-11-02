class ServicesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :verify_slug, only: [:show, :edit, :update]
  after_action :verify_authorized, except: [:index, :show]

  def index
    @services = Service.all
  end

  def new
    # TODO: check if user is an admin
    @service = Service.new
    authorize @service
  end

  def create
    # TODO: check if user is an admin
    @service = Service.new(service_params)
    authorize @service
    if @service.save
      redirect_to @service, notice: 'Your new service has been created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
    authorize @service
    # TODO: check if user is an admin
  end

  def update
    # TODO: check if user is an admin
    authorize @service
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
      params.require(:service).permit(:service_name,
                                      :description,
                                      :price,
                                      :start_time,
                                      :end_time
                                      # :get_service_start,
                                      # :get_service_end
                                      )
    end

end
