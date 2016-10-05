class CatRentalRequestsController < ApplicationController
  def index
    @cat_rental_requests = CatRentalRequest.order(start_date: :asc)
    render :index
  end

  def create
    @cat_rental_request = CatRentalRequest.create(cat_rental_params)

    render :show
  end

  def new
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.all

    render :new
  end

  def update
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
    @cat_rental_request.update(cat_rental_params)

    render :show
  end

  def show
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])

    render :show
  end

  def edit
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])

    render :edit
  end

  def approve
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
    @cat_rental_request.approve!
  end

  def deny
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
    @cat_rental_request.deny!
  end

  private

  def cat_rental_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
  end
end
