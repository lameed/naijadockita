class ProfilesController < ApplicationController

  def edit
    @user = User.find_by(name: params[:name])
  end


  def show
    @user = User.find_by(name: params[:name])
    @posts = User.find_by(name: params[:name]).posts.order('created_at DESC')
  end
end
