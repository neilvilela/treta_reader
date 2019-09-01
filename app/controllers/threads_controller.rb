require 'thread_reader'

class ThreadsController < ApplicationController
  def show
    @thread = ThreadReader.new(params[:id])
  end

  def index
    if params[:tweet_url]
      redirect_to action: :show, id: params[:tweet_url].split("/").last
    end
  end
end
