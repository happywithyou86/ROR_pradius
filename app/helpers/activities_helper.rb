module ActivitiesHelper
  def time_ago(time)
    time_ago_in_words(time)  + " ago"
  end

  def activity_comment_form(activity)
    capture do
      form_for(ActivityComment.new, remote: true, url: { :controller => "activity_comments", :action => "create" }, class: "col-md-3") do |f|
        concat f.hidden_field :klass_name, value: activity.klass
        concat f.hidden_field :klass_id, value: activity.id
        concat "<div class='col-md-6'>".html_safe
        concat f.text_area :comment, class: "form-control", value: "default text"
        concat "</div>".html_safe
        concat "<br>".html_safe
        concat f.submit "Submit", class: "btn btn-success"
      end
    end
  end

  def get_user_link(user)
    "/users/#{user.id}"
  end

  def by_you_or_user_name(user)
    if user.id == current_user.id
      "You"
    else
      user.name
    end
  end

  def activity_details(activity, prid)
    html = ""

    html << content_tag(:a, UserActivity.find_likes(activity.klass.to_s, activity.id, prid, current_user), :"data-id" => activity.id, :"data-class" => activity.klass, class: "like-activity", href: "#recent-activity-section", style: "color:#5BA304;")

    html << " • "

    html << content_tag(:a, "Comment", "data-id" => activity.id, :"data-class" => activity.klass, class: "comment-activity", href: "#recent-activity-section", style:"color:#5BA304;")

    #html << " • Share • #{time_ago(activity.created_at)}"

    html << "<div class='activity' style='display:none'>"

    # Here is the form for adding a comment
    if current_user
      html << "<br>"

      html << activity_comment_form(activity)
    end

    html << "<div class='row'>"

      html << "<div class='comments col-md-5'>"

        if activity.comments.present?
            user_comment =  activity.comments.inject("") { |result, comment| comment }
        if !user_comment.user.nil?
          html << activity.comments.inject("") { |result, comment| result + "<div class='comment'>
            #{comment.comment}<br>By 
            <a href='#{get_user_link(comment.user)}'>#{by_you_or_user_name(comment.user)}</a>
            #{time_ago(comment.created_at)}</div>" }
          end
        else
          html << "No comments yet"
        end

      html << "</div>"

      html << "</div>"

    html << "</div>"


    return html.html_safe
  end
end
