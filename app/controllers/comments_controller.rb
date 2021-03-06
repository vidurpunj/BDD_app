class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_article, only: [:create]

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      ActionCable.server.broadcast "comments", render(:partial => 'comments/comment', locals: {comment: @comment})
      flash[:notice] = 'Comment has been created.'
    else
      flash.now[:alert] = 'Comment has not been created.'
    end
    # redirect_to article_path(@article)  ## No need of redirecting after Action cables
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def get_article
    @article = Article.find(params[:article_id])
  end

end
