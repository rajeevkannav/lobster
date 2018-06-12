class WarehousesController < ApplicationController

  before_action :set_warehouse, except: [:index, :create]
  before_action :set_stockpile, only: [:activity, :adjustments]
  before_action :set_warehouse_to, only: [:adjustments]

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

  def activity
    @stockpile.do_account(kind: warehouse_activity_params[:kind], quantity: warehouse_activity_params[:quantity].to_i)
    head :ok
  end

  def adjustments
     @to_warehouse_stockpile = @to_warehouse.stockpiles.find_or_create_by(product_id: warehouse_adjustments_params[:product_id])
     Stockpile.transaction do
       @stockpile.do_account(kind: 'remove', quantity: warehouse_adjustments_params[:quantity].to_i)
       @to_warehouse_stockpile.do_account(kind: 'add', quantity: warehouse_adjustments_params[:quantity].to_i)
     end
     head :ok
  end

  def reports
  end

  private

  def warehouse_params
    params.permit(:name)
  end

  def set_warehouse
    @warehouse = Warehouse.find params[:id]
  end

  def set_warehouse_to
    @to_warehouse = Warehouse.find params[:to_warehouse_id]
  end

  def warehouse_activity_params
    params.permit(:product_id,  :kind, :quantity)
  end

  def warehouse_adjustments_params
    params.permit(:to_warehouse_id , :product_id, :quantity)
  end

  def set_stockpile
    @stockpile = @warehouse.stockpiles.find_or_create_by(product_id: params[:product_id])
  end

end
