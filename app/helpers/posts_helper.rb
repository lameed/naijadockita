module PostsHelper

  def display_likes(post)
    votes = post.votes_for.up.by_type(User)
    return list_likers(votes) if votes.size <= 8
    count_likers(votes)
  end
  # Our new helper method


  def liked_post(post)
    if current_user.voted_for? post
      return link_to '', unlike_post_path(post), remote: true, id: "like_#{post.id}",
          class: "glyphicon glyphicon-heart"
    else
      link_to '', like_post_path(post), remote: true, id: "like_#{post.id}",
          class: "glyphicon glyphicon-heart-empty"
    end
  end


  private

  def list_likers(votes)
   names = []
   unless votes.blank?
     votes.voters.each do |voter|
       names.push(link_to voter.name,
                               profile_path(voter.name),
                               class: 'user-name')
     end
     names.to_sentence.html_safe + like_plural(votes)
   end
 end

 def count_likers(votes)
   return "#{votes.size} likes"
 end

  def like_plural(votes)
    # If we more than one like for a post, use ' like this'
    return ' like this' if votes.count > 1
    # Otherwise, return ' likes this'
    ' likes this'
  end

end
