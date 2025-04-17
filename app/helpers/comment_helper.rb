module CommentHelper
  def comment_title(action_type)
    case action_type
    when "added" then "Comment was added"
    when "updated" then "Comment was updated"
    when "removed" then "Comment was removed"
    else "Left a comment"
    end
  end
end
