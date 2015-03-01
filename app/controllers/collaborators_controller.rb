class CollaboratorsController < ApplicationController
  
  
  def index
    @wiki = Wiki.find params[:wiki_id]
    @users = User.all
   @collab = @wiki.collaborators
  end

  def new
   # Collaborators.new
    
  end

  def show
           @wiki = Wiki.find(params[:wiki_id])
           #@collab = @wiki.collaborators.find(params[:id])
        
           #@collab = @wiki, Collaborator.find(params[:id])
           #@a = "#{Collaborator.find(params[:id]).id.methods}------- #{Collaborator.find(params[:id]).destroy}  "
             if @wiki.collaborators.find(params[:id]).destroy
             flash[:notice] = "Collaborator removed."
             redirect_to wiki_collaborators_path(@wiki)
             #redirect_to root_path
             end 
        
         
    
     end

  def edit
    
  end
  
  def create
    @wiki = Wiki.find params[:wiki_id]
    collab = @wiki.collaborators.build user_id: params[:user_id]
    if collab.save
      redirect_to wiki_collaborators_path(@wiki), notice: 'User added'
    else
      redirect_to wiki_collaborators_path(@wiki), error: 'problem saving'
    end
  end
  
#   def destroy
#         @wiki = Wiki.find(params[:id])
#     #@collab = @wiki.collaborators.find(params[:id])
#     @collab = @wiki.collaborators.find(params[:id])
#     @collab2 = Collaborator.find(params[:id]).id
#     # name = @wiki.collaborator
 
#      #authorize @topic
#      if @collab2.destroy
#        flash[:notice] = "Collaborator removed."
#       # redirect_to wiki_collaborators_path(@wiki)
#        redirect_to root
#      else
#        flash[:error] = "There was an error deleting the topic."
#        render :show
#      end
#    end
 
end
