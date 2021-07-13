class CommentsController < ApplicationController
  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@prototype.id)
    else
      @comments = @prototype.comments
      render "prototypes/show"
    end
  end

  def show
    @comments = Comment.includes(:user)
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: @prototype.id)
  end
end