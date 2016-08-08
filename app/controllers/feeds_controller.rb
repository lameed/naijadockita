class FeedsController < ApplicationController
  def index
	
	end

	def show

		@feed = feed.where.not(id: @feed).order("RANDOM()").first
	end

	def new
		@feed = current_user.feeds.build
	end

	def create
		@feed = current_user.feeds.build(feed_params)

		if @feed.save
			redirect_to @feed
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
		@feed = feed.find(params[:id])
	end

	def feed_params
		params.require(:feed).permit(:content)
	end
end
