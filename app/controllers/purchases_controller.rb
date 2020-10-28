class PurchasesController < ApplicationController
  before_action :move_to_index, only: :index
  before_action :set_purchase_address, only: [:index, :create]
  before_action :authenticate_user!, only: :index

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(set_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end
 
  private
  
  def set_params
    params.require(:purchase_address).permit(:postal_number, :prefecture_id, :city, :house_number, :building_name, :phone_number, :purchase_id).merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id])
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    if @item.purchase
      redirect_to root_path
    elsif !user_signed_in?
      redirect_to new_user_session_path
    elsif current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def set_purchase_address
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: set_params[:token],
      currency: 'jpy'
    )
  end

end