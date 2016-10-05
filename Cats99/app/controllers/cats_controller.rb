class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by(id: params[:id])
    render :show
  end

  def new
    @cat = Cat.new

    render :new
  end

  def create
    @cat = Cat.create(cat_params)

    render :show
  end

  def update
    @cat = Cat.find_by(id: params[:id])
    @cat.update(cat_params)

    render :show
  end

  def edit
    @cat = Cat.find_by(id: params[:id])

    render :edit
  end
  private

  def cat_params
    params.require(:cat).permit(:name, :sex, :color, :birth_date, :description)
  end
end
