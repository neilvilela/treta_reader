require 'thread_reader'

class ThreadsController < ApplicationController
  def show
    @thread = ThreadReader.new(params[:id])
  end

  def sample
    @thread = SampleThread.new

    render :show
  end

  def index
    if params[:tweet_url]
      redirect_to action: :show, id: params[:tweet_url].split("/").last
    end
  end

  private

  class SampleThread
    def unroll
      JSON.parse(File.read(Rails.root.join("test", "fixtures", "sample_thread.json"))).map do |tweet|
        Twitter::Tweet.new(tweet.with_indifferent_access)
      end
    end
  end
end
