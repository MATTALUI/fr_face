class PostsController < ApplicationController
  def create
    id = JSON.parse(cookies.signed[:user])["id"]
    @new_post = Post.new(new_post_params)
    @new_post.user_id = id
    if @new_post.save then
      redirect_back fallback_location: root_path
    end
  end


  private
    def new_post_params
      return params.require(:post).permit(:body)
    end
end
