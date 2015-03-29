class CommentsController < ApplicationController
	before_filter :load_article, :except => :destroy
	before_filter :authenticate, :only => :destroy

	def create
		@comment = @article.comments.new(comment_params)
		if @comment.save
			respond_to do |format|
				format.html { redirect_to @article, notice: 'Thanks for your comment' }
				format.js#this block will render create.js.erb 
			end
			# redirect_to @article, notice: 'Thanks for your comment'
		else
			respond_to do |format|
				format.html { redirect_to @article, alert: 'Unable to add comment' }
				format.js { render 'fail_create.js.erb' }
			end
			# redirect_to @article, alert: 'Unable to add comment'
		end
	end
	
	def destroy
		@article = current_user.articles.find(params[:article_id])
		@comment = @article.comments.find(params[:id])
		@comment.destroy
		respond_to do |format|
			format.html{redirect_to @article, notice: 'Comment Deleted'}
			format.js
		end
	end
	
	private
	def load_article
		@article = Article.find(params[:article_id])
	end
	
	def comment_params
		params.require(:comment).permit(:name, :email, :body)
	end
end
