require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント' do
    context 'コメントがうまくいくとき' do
      it 'textがあればコメントできる' do
        expect(@comment).to be_valid
      end
    end

    context 'コメントがうまくいかないとき' do
      it 'textがなければコメントできない' do
        @comment.text = ""
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")
      end
    end
  end
end