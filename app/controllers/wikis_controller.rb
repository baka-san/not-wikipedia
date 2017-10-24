class WikisController < ApplicationController

  # def index
  # end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private 

    def wiki_params
      params.require(:wiki).allow(:title, :body, :private)
    end

end
