module ArticlesHelper
  def persisted_comments(comments)
    comments.reject{ |comment| comment.new_record? }  ## we want only comment in the database, no new comments
  end

end
