class CommentsController < ApplicationController
  before_action :get_article, only: [:create]

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = 'Comment has been created.'
    else
      flash.now[:alert] = 'Comment has not been created.'
    end
    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def get_article
    @article = Article.find(params[:article_id])
  end

end
