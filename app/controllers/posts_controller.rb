class PostsController < ApplicationController

  def index
     if   params[:share].present? && params[:share] =="true"
        session[:page_id] = 0
        params[:page] = 1
    end
      if !session[:page_id].nil?
        session[:page_id] = session[:page_id] + 1
        params[:page] = session[:page_id]
      end
       @posts = Post.post_feed_for_user(current_user, params[:page])
        render partial: '/posts/user_post_feed', locals: {posts: @posts}
    
  end

  def create
    
    post = current_user.posts.create(post_params)
   @posts = Post.post_feed_for_user(current_user, params[:page])

    render json: { partial: render_to_string( partial: '/static_pages/post', locals: { posts: @posts} ) }, status: :ok
   # redirect_to root_path, layout: false
  end

  def like

    post = Post.find(params[:post_id])
    if post.is_liked_by_user?(current_user)
      like = Like.find_likes_for_type('Post', post.id, current_user.id)
      
      like.destroy
    else
      if current_user.opt_in == true
        UserMailer.user_like(post,current_user,post.user)
      end
      like = post.likes.create(user_id: current_user.id)
       ActivityLike.create(user_id: current_user.id,klass_id: post.id,klass_name: "Post") 
    end
    render json: {}, status: :ok
  end

  def user_lists
   post = Post.find(params[:post_id])
   users = User.find_all_by_id(post.likes.collect(&:user_id)).collect(&:name)
     if !users.blank?
       render json: { partial: render_to_string( partial: '/posts/user_lists', locals: { user_lists: users} ), id: post.id }, status: :ok
     else
       render json: {}, status: :ok
     end
  end

  

  private
    def post_params
      params.require(:post).permit(:status, :image)
    end

end
