class CatchAllController < ApplicationController
  def index
    if id = params[:path].match(/(?<=status\/)\d+/)
      redirect_to thread_path(id.to_s)
    else
      head :not_found
    end
  end
end
