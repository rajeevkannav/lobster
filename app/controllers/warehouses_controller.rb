class WarehousesController < ApplicationController

  def index
    @warehouses = Warehouse.all
    json_response(@warehouses)
  end

end
