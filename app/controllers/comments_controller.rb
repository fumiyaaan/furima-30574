class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :set_item

  def create
    @comment = Comment.new(comment_params)
    @comment.valid?
    if @comment.save
      ActionCable.server.broadcast 'comment_channel', content: @comment
    else
      render template: 'items/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
    @comments = @item.comments.includes(:user)
  end
end
