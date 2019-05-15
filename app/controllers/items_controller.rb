class ItemsController < ApplicationController
  before_action :set_department
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  def index
    @items = @department.items
  end

  def show
  end

  def new
    @item = @department.items.new
    render partial: "form"
  end

  def create
    @item = @department.items.new(items_params)

    if @item.save
      redirect_to department_item_path(@department.id, @item.id)
    else
      render partial: "form"
    end
  end

  def edit
    render partial: "form"
  end

  def update
    if @item.update(items_params)
      redirect_to department_item_path(@department.id, @item.id)
    else
      render partial: "form"
    end
  end

  def destroy
    @item.destroy
    redirect_to department_items_path(@department.id)
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def set_department
      @department = Department.find(params[:department_id])
    end

    def items_params
      params.require(:item).permit(:name, :description, :price)
    end
end
