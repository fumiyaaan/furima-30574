class PurchasesController < ApplicationController
  def index
    @purchases = PurchaseAddress.all
  end

  def create
  end
end
