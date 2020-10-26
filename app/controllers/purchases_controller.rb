class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :move_to_index, only: :index

  def index
    @purchase_address = PurchaseAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    @purchase_address = PurchaseAddress.new(set_params)
    
    if @purchase_address.valid?
      @purchase_address.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private
  
  def set_params
    params.require(:purchase_address).permit(:postal_number, :prefecture_id, :city, :house_number, :building_name, :phone_number, :purchase_id).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    if user_signed_in? && current_user.id == @item.user_id
      redirect_to root_path
    end
  end
end