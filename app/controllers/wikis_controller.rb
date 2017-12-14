class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @wikis = policy_scope(Wiki)
    # @index = WikiPolicy::CurrentUserScope.new(current_user, @wikis).resolve
    @index = @wikis

    # could use HasScope easily...just link_to your queries
    # https://github.com/plataformatec/has_scope
    # Shouldn't I use pundit?

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
    authorize @wiki 

    if @wiki.save
      flash[:notice] = "Wiki created."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error creating the wiki. Please try again."
      render :new
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

end
