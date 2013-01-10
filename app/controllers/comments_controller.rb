class CommentsController < ApplicationController
  http_basic_authenticate_with :name => "dhh", :password => "secret", :only => :destroy
before_filter :find_post
def find_post
  @post = Post.find(params[:post_id])
end

  def create
   
       @comment = @post.comments.new(params[:comment])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  def edit
 
    @comment = Comment.find(params[:id])
  end
  def update
  
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
      @comment = @post.comments.find(params[:id])
      @comment.destroy
      redirect_to post_path(@post)
    end
end
