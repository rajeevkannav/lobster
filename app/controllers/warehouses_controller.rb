class WarehousesController < ApplicationController

  before_action :set_warehouse, only: [:show, :update, :destroy]

  def index
    @warehouses = Warehouse.all
    json_response(@warehouses)
  end

  def create
    @warehouse = Warehouse.create!(warehouse_params)
    json_response(@warehouse, :created)
  end

  def show
    json_response(@warehouse)
  end

  def update
    @warehouse.update(warehouse_params)
    head :no_content
  end

  def destroy
    @warehouse.destroy
    head :no_content
  end

  private

  def warehouse_params
    params.permit(:name)
  end

  def set_warehouse
    @warehouse = Warehouse.find params[:id]
  end

end
