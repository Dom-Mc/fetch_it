class ServicesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :verify_slug, only: [:show, :edit, :update]
  after_action :verify_authorized, except: [:index, :show]

  def index
    @services = Service.all
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @services }
    end
  end

  def new
    @service = Service.new
    authorize @service
  end

  def create
    @service = Service.new(service_params)
    authorize @service

    respond_to do |format|
      if @service.save
        format.html { redirect_to @service, notice: 'Service was successfully created.' }
        format.json { render json: @service, status: 201 }
      else
        format.html { render :new }
        format.json { render json: @service.errors.as_json(full_messages: true), status: 400 }
      end
    end
  end

  def show
  end

  def edit
    authorize @service
  end

  def update
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
      params.require(:service).permit(
        :service_name,
        :description,
        :price,
        :start_time,
        :end_time
      )
    end

end
