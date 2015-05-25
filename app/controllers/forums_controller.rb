class ForumsController < ApplicationController
  before_action :redirect_non_signed_in_user
  
  # before_action :redirect_non_premium_user

  include ForumsHelper

  def search_thread
    thread = ForumThread.find(params[:forum_thread_id])

    @data = {
      thread: thread,
      posts: SearchForum.thread(params[:search_term], thread, params[:page]),
      users_in_area: PeopleSuggestion.find_local_users_in_area(current_user),
      users_from_casino: PeopleSuggestion.find_users_from_fav_casino(current_user),
      online_site_users: PeopleSuggestion.find_users_from_fav_site(current_user),
      interested_groups: DiscussionGroup.find_interested_groups(current_user, 5)
    }
  end

  def search_threads
    forum_section = ForumSection.find(params[:forum_section_id])

    @data = {
      section: forum_section,
      threads: SearchForum.threads(params[:search_term], forum_section, params[:page]),
      users_in_area: PeopleSuggestion.find_local_users_in_area(current_user),
      users_from_casino: PeopleSuggestion.find_users_from_fav_casino(current_user),
      online_site_users: PeopleSuggestion.find_users_from_fav_site(current_user),
      last_post: forum_section.last_post,
      interested_groups: DiscussionGroup.find_interested_groups(current_user, 5)
    }
  end


  def section
    forum_section = ForumSection.find(params[:id])

    @data = {
      users_in_area: PeopleSuggestion.find_local_users_in_area(current_user),
      threads: ForumThread.where("forum_section_id = ?", params[:id]).order("created_at DESC").paginate(:page => params[:page], :per_page => 12).includes(:user).to_a,
      forum_section: forum_section,
      last_post: forum_section.last_post,
      users_from_casino: PeopleSuggestion.find_users_from_fav_casino(current_user),
      online_site_users: PeopleSuggestion.find_users_from_fav_site(current_user),
      interested_groups: DiscussionGroup.find_interested_groups(current_user, 5)
    }
  end

  def thread
    forum_thread = ForumThread.find(params[:id])

    forum_thread.increment_view!

    @data = {
        users_in_area: PeopleSuggestion.find_local_users_in_area(current_user),
        thread: forum_thread,
        posts: ForumPost.where("forum_thread_id = ?", params[:id]).paginate(:page => params[:page], :per_page => 5).includes(:user).includes(:user => :user_profile_picture).includes(:user => :user_location).order("created_at DESC").to_a,
        users_from_casino: PeopleSuggestion.find_users_from_fav_casino(current_user),
        online_site_users: PeopleSuggestion.find_users_from_fav_site(current_user),
        interested_groups: DiscussionGroup.find_interested_groups(current_user, 5)
      }

  end

  def index
    @data = {  users_in_area: PeopleSuggestion.find_local_users_in_area(current_user),
               forums: Forum.includes(:forum_sections).to_a,
               users_from_casino: PeopleSuggestion.find_users_from_fav_casino(current_user),
               online_site_users: PeopleSuggestion.find_users_from_fav_site(current_user),
               interested_groups: DiscussionGroup.find_interested_groups(current_user, 5)
            }
  end

  def new_post
    @contact_form = ContactForm.new
    @data = { forum_post: ForumPost.new,
              thread: ForumThread.find(params[:id]),
              users_in_area: PeopleSuggestion.find_local_users_in_area(current_user),
              users_from_casino: PeopleSuggestion.find_users_from_fav_casino(current_user),
              online_site_users: PeopleSuggestion.find_users_from_fav_site(current_user),
              interested_groups: DiscussionGroup.find_interested_groups(current_user, 5)
    }
  end

  def create_post
    all_forum_user =  ForumPost.where("forum_thread_id = ?",  params[:forum_post]["forum_thread_id"]).paginate(:page => params[:page], :per_page => 5).includes(:user).includes(:user => :user_profile_picture).includes(:user => :user_location).collect(&:user).uniq
    thread_name = ForumThread.find(params[:forum_post]["forum_thread_id"]).name
    forum_post = ForumPost.create(forum_post_params)

    if forum_post
      flash[:success] = "Thanks! We just posted your comment.  Check out other groups that may interest you."
      if  all_forum_user.collect(&:id).include?(current_user.id)
        puts "1111111111"
         all_user= all_forum_user  - [current_user]
      else
        puts "2222222222"
        all_user = all_forum_user
      end
        puts "3333333333"

      all_user.each do |user|
           if current_user.opt_in == true
             UserMailer.forum_post(current_user,user,thread_name,params["forum_post"]["message"])
           end
      end
      redirect_to "/forums/thread/#{forum_post.forum_thread_id.to_s}"
    else
      @data = { forum_post: forum_post,
                thread: ForumThread.find(forum_post_params[:forum_thread_id]),
                users_in_area: PeopleSuggestion.find_local_users_in_area(current_user),
                users_from_casino: PeopleSuggestion.find_users_from_fav_casino(current_user),
                online_site_users: PeopleSuggestion.find_users_from_fav_site(current_user),
                interested_groups: DiscussionGroup.find_interested_groups(current_user, 5)
      }
      render 'new_post'
    end
  end

  def new_thread
    @contact_form = ContactForm.new
    @data = { forum_thread: ForumThread.new_with_build,
              section: ForumSection.find(params[:id]),
              users_in_area: PeopleSuggestion.find_local_users_in_area(current_user),
              users_from_casino: PeopleSuggestion.find_users_from_fav_casino(current_user),
              online_site_users: PeopleSuggestion.find_users_from_fav_site(current_user),
              interested_groups: DiscussionGroup.find_interested_groups(current_user, 5)
    }
  end

  def create_thread
    forum_thread = ForumThread.create(forum_thread_params)
   
    if forum_thread
      flash[:success] = "Thread created"

      redirect_to "/forums/thread/#{forum_thread.id.to_s}"
    else
      @data = { forum_thread: forum_thread,
                thread: ForumThread.find(params[:id]),
                users_in_area: PeopleSuggestion.find_local_users_in_area(current_user),
                users_from_casino: PeopleSuggestion.find_users_from_fav_casino(current_user),
                online_site_users: PeopleSuggestion.find_users_from_fav_site(current_user),
                interested_groups: DiscussionGroup.find_interested_groups(current_user, 5)
      }
      render 'new_thread'
    end
  end

  private

  def forum_post_params
    params[:forum_post][:user_id] = current_user.id
    params.require(:forum_post).permit(:message, :forum_thread_id, :user_id)
  end

  def forum_thread_params
    params[:forum_thread][:user_id] = current_user.id

    params[:forum_thread][:forum_posts_attributes]["0"][:user_id] = current_user.id


    params.require(:forum_thread).permit(:name, :forum_section_id, :user_id,
                                         forum_posts_attributes: [:message, :user_id]
    )
  end
end
