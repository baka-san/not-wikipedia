class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index

    @wikis = policy_scope(Wiki)

    if params[:filter].present?
      if filter_params[:my_wikis]
        @index = current_user.wikis 
      elsif filter_params[:collaborating]
        @index = current_user.collaborating 
      end

      @message = @index.empty? ? "None found." : nil 
    else
      @index = @wikis 
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new


  end

  def create

    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    # @collaborators = 
    authorize @wiki 


byebug
    respond_to do |format|
      format.js
      format.html {
        if @wiki.save
          flash[:notice] = "Wiki created."
          redirect_to @wiki
        else
          flash.now[:alert] = "There was an error creating the wiki. Please try again."
          render :new
        end
      }

    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Page was updated. Jesus will check the validity later."
      redirect_to @wiki
    else
      flash.now[:alert] = "Error saving page. Did you write something dumb? Anyways, try again when you're smarter."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" is dead. Good job, you killed it."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error killing the wiki. The police will arrive shortly."
      render :show
    end
  end

  private 

    def wiki_params
      params.require(:wiki).permit(:title, :body, :private)
    end

    # def collaborator_params
    #   params.require(:)
    # end

    def filter_params
      params.require(:filter).permit(:my_wikis, :collaborating)
    end

end
