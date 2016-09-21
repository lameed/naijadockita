class FeedsController < ApplicationController
  layout 'main_layout'
  before_action :find_feed, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  def index
    @feeds= Feed.all.order("Created_at DESC")
    @feed = current_user.feeds.build
    @comments = Comment.where(feed_id: @feed)
	end

	def show
    @comments = Comment.where(feed_id: @feed)
		@random_feed = Feed.where.not(id: @feed).order("RANDOM()").first

	end

	def new
	  @feed = current_user.feeds.build
	end

  def edit
    @feed = Feed.find(params[:id])
  end

	def create
		@feed = current_user.feeds.build(feed_params)

		if @feed.save
			redirect_to root_path
		else
			render 'new'
		end
	end


	def edit
	end

	def update
		if @feed.update(feed_params)
			redirect_to @feed
		else
			render 'edit'
		end
	end

	def destroy
		@feed.destroy
		redirect_to root_path
	end

	# def upvote
	# 	@feed.upvote_by current_user
	# 	redirect_to :back
	# end

	# def downvote
	# 	@feed.downvote_by current_user
	# 	redirect_to :back
	# end



	private

	def find_feed
		@feed = Feed.find(params[:id])
	end

	def feed_params
		params.require(:feed).permit(:content, :image)
	end
end
