class PurchasesController < ApplicationController
  def index
    @purchase = PurchaseAddress.new
  end

  def create
  end
end
