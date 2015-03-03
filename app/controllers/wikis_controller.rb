class WikisController < ApplicationController
  def index
#     if current_user
       @wikis = Wiki.all
#     else 
#       #@wiki = Wiki.where( public: true )
#       @wiki = Wiki.public_only
#     end
#    @wiki = Wiki.visible_for (current_user)
    authorize @wikis
   # @collaborators = Collaborator.all
  end

  def show
    @wiki = Wiki.find(params[:id])
    @collaborator = @wiki.collaborators
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
    
  end
  
     def create
       @wiki = current_user.wikis.new(params.require(:wiki).permit(:title, :body)) #record user
       # @wiki = Wiki.new(params.require(:wiki).permit(:title, :body))  #dont record user
       authorize @wiki
     if @wiki.save
       flash[:notice] = "Wiki was saved."
       redirect_to @wiki
     else
       flash[:error] = "There was an error saving the wiki. Please try again."
       render :new
     end
     end


  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @users = User.all
   @collab = @wiki.collaborators
  end
  
   def update
     @wiki = Wiki.find(params[:id])
     authorize @wiki
     if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private ))
       flash[:notice] = "Wiki was updated."
       redirect_to @wiki
     else
       flash[:error] = "There was an error saving the wiki. Please try again."
       render :edit
     end
   end

     def destroy
     @wiki = Wiki.find(params[:id])
       name = @wiki.title
 
     #authorize @wiki
     if @wiki.destroy
       flash[:notice] = "\"#{name}\" was deleted successfully."
       redirect_to wikis_path
     else
       flash[:error] = "There was an error deleting the wiki."
       render :show
     end
   end
  
    def premium_update
    
    end

  
end
